import 'package:app/app.dart';
import 'package:artifact/artifact.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_unit/src/starter/bridge/unit_bridge.dart';
import 'package:note/note.dart' as note;

/// 仅显式运行时连接本机测试服务，常规单元测试不依赖网络。
const bool runSmoke = bool.fromEnvironment('ARTICLE_HTTP_SMOKE');
const String markdownId = String.fromEnvironment('ARTICLE_MARKDOWN_ID');

void main() {
  if (runSmoke || markdownId.isNotEmpty) setUpAll(registerFlutterUnitHost);
  test('应用 HTTP 桥接可以读取迁移后的文章和专栏', testHttpBridge, skip: !runSmoke);
  test('应用 HTTP 桥接可以读取转换后的本站正文', testMarkdownBridge, skip: markdownId.isEmpty);
  test('首页固定资讯可以通过标签读取同步的 8 条记录', testNewsBridge, skip: !runSmoke);
}

Future<void> testNewsBridge() async {
  note.NoteEnv().attachBridge(UnitNoteBridge());
  final note.NewsBloc news = note.NewsBloc();
  addTearDown(news.close);
  await news.refreshFromNet();
  final List<note.ArticlePo> items = news.state.headerNews;
  expect(items.length, 8);
  expect(items.map((note.ArticlePo item) => item.id).toSet().length, 8);
  expect(items.first.title, 'Flutter 3.47 发布，快来看看有什么更新吧');
  for (final note.ArticlePo item in items) {
    expect(item.type, 0);
    expect(item.status, 0);
    expect(Uri.parse(item.url).scheme, 'https');
    expect(item.cover, startsWith('https://fx.toly1994.com/unit/uploads/'));
  }
  // 首页内容不能混入任何文库分页，过滤应在服务端完成。
  ArtifactEnv().attachBridge(UnitArtifactBridge());
  final Set<String> newsIds =
      items.map((note.ArticlePo item) => item.id.toString()).toSet();
  const ArticleRepository library = ArticleRepository();
  String? cursor;
  do {
    final ArticlePage page = await library.query(
      const ArticleFilter(pageSize: 100),
      cursor: cursor,
    );
    for (final Article article in page.items) {
      expect(newsIds.contains(article.id), isFalse);
    }
    if (page.nextCursor != null) expect(page.nextCursor, isNot(cursor));
    cursor = page.nextCursor;
  } while (cursor != null);
}

Future<void> testMarkdownBridge() async {
  ArtifactEnv().attachBridge(UnitArtifactBridge());
  const ArticleRepository articles = ArticleRepository();
  String? cursor;
  Article? converted;
  // 批量转换后也抽检较早文章，不能假定目标总在第一页。
  do {
    final ArticlePage page = await articles.query(
      const ArticleFilter(pageSize: 100),
      cursor: cursor,
    );
    for (final Article item in page.items) {
      if (item.id == markdownId) {
        converted = item;
        break;
      }
    }
    if (page.nextCursor != null) expect(page.nextCursor, isNot(cursor));
    cursor = page.nextCursor;
  } while (converted == null && cursor != null);
  expect(converted, isNotNull, reason: '目录中应存在要抽检的本站文章');
  final Article selected = converted!;
  expect(selected.type, 2);
  final MarkdownArticle document = await articles.openMarkdown(markdownId);
  expect(document.content, isNotEmpty);
  expect(document.sourceUrl, selected.url);
}

Future<void> testHttpBridge() async {
  ArtifactEnv().attachBridge(UnitArtifactBridge());
  const ArticleRepository articles = ArticleRepository();
  const ColumnizeRepository columns = ColumnizeRepository();
  final ArticlePage first =
      await articles.query(const ArticleFilter(pageSize: 23));
  // 文库可另行发布文章；首页资讯独立管理，不计入文库总数。
  expect(first.total, greaterThanOrEqualTo(358));
  expect(first.items.length, 23);
  expect(first.nextCursor, isNotNull);
  final ArticlePage next = await articles.query(
    const ArticleFilter(pageSize: 23),
    cursor: first.nextCursor,
  );
  expect(next.items.first.id, isNot(first.items.last.id));
  final List<Columnize> collections = await columns.query();
  // 完整文档重建后允许没有专栏，后续新建专栏仍验证筛选和计数。
  if (collections.isEmpty) {
    final ArticlePage removed = await articles.query(
      const ArticleFilter(groupId: '1', pageSize: 100),
    );
    expect(removed.total, 0);
    expect(removed.items, isEmpty);
    expect(removed.nextCursor, isNull);
    return;
  }
  final ArticlePage filtered = await articles.query(
    ArticleFilter(groupId: collections.first.id, pageSize: 100),
  );
  expect(filtered.total, collections.first.count);
  expect(filtered.items.length, collections.first.count);
  expect(filtered.nextCursor, isNull);
}
