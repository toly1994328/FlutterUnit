import 'package:artifact/src/articles/bloc/exp.dart';
import 'package:artifact/src/articles/data/exp.dart';
import 'package:artifact/src/articles/view/library/library_page.dart';
import 'package:artifact/src/articles/view/library/article_browser.dart';
import 'package:artifact/src/articles/view/library/library_controller.dart';
import 'package:artifact/src/articles/view/library/library_controls.dart';
import 'package:artifact/src/articles/view/library/article_card.dart';
import 'package:artifact/src/articles/view/library/article_tags.dart';
import 'package:artifact/src/articles/view/library/topic_options.dart';
import 'package:artifact/src/articles/view/library/topic_filter_button.dart';
import 'package:artifact/src/articles/view/article/columnize_page_view.dart';
import 'package:artifact/src/articles/view/article/markdown_article_page.dart';
import 'package:artifact/src/articles/view/article/reading/reading_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'support/reading_image_cache.dart';

/// 提供可检索的目录，记录真实筛选请求。
class LibraryRepository extends ArticleRepository {
  /// 控制输入防抖和主题筛选的断言。
  final List<ArticleFilter> requests = <ArticleFilter>[];

  /// 示例文章，验证列表标签及阅读页的主题信息。
  final Article item = Article(
      id: '1',
      type: 2,
      title: 'Flutter 绘制入门',
      subtitle: '用 Canvas 绘制路径，学习 Flutter 动画与绘图。',
      url: 'https://example.com/source',
      authoredAt: DateTime(2022, 2, 17),
      tags: const <ArticleTopic>[ArticleTopic(id: '2', name: 'Canvas')]);
  @override
  Future<ArticlePage> query(ArticleFilter filter, {String? cursor}) async {
    requests.add(filter);
    final bool matches = item.title.contains(filter.query);
    return ArticlePage(
        items: matches ? <Article>[item] : <Article>[], total: matches ? 1 : 0);
  }

  @override
  Future<List<ArticleTopic>> topics({String? groupId}) async =>
      const <ArticleTopic>[
        ArticleTopic(id: '2', name: 'Canvas', group: '绘制', count: 1)
      ];
  @override
  Future<MarkdownArticle> openMarkdown(String id) async =>
      const MarkdownArticle(
          title: 'Flutter 绘制入门',
          content: '# Flutter 绘制入门\n\n正文支持选择和阅读。\n\n![路径图片](images/path.png)',
          sourceUrl: 'https://example.com/source',
          resourceBaseUrl: 'http://localhost:9602/articles/one/');
}

class LibraryCollections extends ColumnizeRepository {
  @override
  Future<List<Columnize>> query() async => const <Columnize>[
        Columnize(
            id: '10',
            title: 'Flutter 绘制与动画',
            subtitle: '从基础图形到交互动画，循序渐进学习。',
            count: 12),
        Columnize(id: '11', title: 'Dart 语言', subtitle: '语言基础与进阶。', count: 8),
        Columnize(
            id: '12', title: 'Flutter 原理', subtitle: '理解渲染与生命周期。', count: 10),
        Columnize(
            id: '13', title: 'Flutter 工程', subtitle: '应用架构与工程实践。', count: 16),
        Columnize(id: '14', title: '编程随笔', subtitle: '记录学习与创作。', count: 6),
      ];
}

void main() {
  setUp(configureReadingImageCache);
  tearDown(resetReadingImageCache);
  testWidgets('搜索提升到顶部后仅有一个输入框，筛选与列表共享状态', testPromotedControls);
  testWidgets('窄屏文库不溢出，检索防抖且列表展示主题', testCompactSearch);
  testWidgets('顶部专栏可横向滑动，详情查询保持专栏条件', testCollectionNavigation);
  testWidgets('手机主题和排序从底部弹框提交，清空恢复全文库', testTopics);
  testWidgets('阅读页解析本站图片并展示主题，顶部保持简洁', testReader);
  testWidgets('搜索在专栏上方，全部专栏入口可直达文章', testAllCollections);
  testWidgets('长标题和多标签在窄卡片中不溢出', testArticleTags);
}

Future<void> testPromotedControls(WidgetTester tester) async {
  tester.view.physicalSize = const Size(360, 800);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  final LibraryRepository repository = LibraryRepository();
  final ArticleBloc bloc = ArticleBloc(repository)..init();
  final ColumnizeBloc collections = ColumnizeBloc(LibraryCollections())..init();
  final LibraryController controls = LibraryController(bloc);
  await tester.pumpWidget(MaterialApp(
      home: MultiBlocProvider(
          providers: <BlocProvider<dynamic>>[
        BlocProvider<ArticleBloc>.value(value: bloc),
        BlocProvider<ColumnizeBloc>.value(value: collections),
      ],
          child: Scaffold(
              appBar: AppBar(
                  title: LibraryControls(controller: controls, compact: true)),
              body: ArticleBrowser(
                  controller: controls,
                  showToolbar: false,
                  showCollections: true)))));
  await tester.pumpAndSettle();
  expect(find.byType(TextField), findsOneWidget);
  expect(tester.getTopLeft(find.byType(TextField)).dy,
      lessThan(tester.getTopLeft(find.byType(ColumnizePageView)).dy));
  await tester.enterText(find.byType(TextField), '找不到');
  await tester.pump(const Duration(milliseconds: 400));
  await tester.pumpAndSettle();
  expect(repository.requests.last.query, '找不到');
  expect(find.text('没有匹配的文章，试试其他关键词或主题'), findsOneWidget);
  await tester.tap(find.byTooltip('清空筛选'));
  await tester.pumpAndSettle();
  expect(find.text('Flutter 绘制入门'), findsOneWidget);
  await tester.tap(find.byIcon(Icons.swap_vert_rounded));
  await tester.pumpAndSettle();
  await tester.tap(find.text('最早创作'));
  await tester.pumpAndSettle();
  expect(repository.requests.last.sort, 'oldest');
  expect(tester.takeException(), isNull);
  await tester.pumpWidget(const SizedBox.shrink());
  // 外部控制器由顶部页面持有，列表卸载不能提前销毁它。
  expect(controls.search.text, '');
  controls.dispose();
  await bloc.close();
  await collections.close();
}

Future<void> testArticleTags(WidgetTester tester) async {
  const Article article = Article(
      id: 'tagged',
      title: 'Flutter 绘制与动画：从基础路径到复杂交互的实现与原理',
      subtitle: '从基础路径开始，逐步实现复杂动画与交互效果，理解绘制流程。',
      username: '张风捷特烈',
      url: 'https://example.com/source',
      cover: 'https://example.com/cover.png',
      tags: <ArticleTopic>[
        ArticleTopic(id: '1', name: 'Flutter 自定义绘制与动画'),
        ArticleTopic(id: '2', name: 'Canvas'),
        ArticleTopic(id: '3', name: 'Path'),
        ArticleTopic(id: '4', name: '动画'),
        ArticleTopic(id: '5', name: '交互设计'),
        ArticleTopic(id: '6', name: 'Flutter 渲染原理'),
        ArticleTopic(id: '7', name: '性能优化'),
        ArticleTopic(id: '8', name: '工程实践'),
      ]);
  await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
          body: Center(
              child: SizedBox(
                  width: 280,
                  height: 196,
                  child: LibraryArticleCard(article: article))))));
  Future<void> decode() => precacheImage(
      const CachedNetworkImageProvider('https://example.com/cover.png'),
      tester.element(find.byType(MaterialApp)));
  await tester.runAsync(decode);
  await tester.pumpAndSettle();
  expect(find.text('Canvas'), findsOneWidget);
  final Finder labels = find.descendant(
      of: find.byType(ArticleTags), matching: find.byType(Text));
  final Set<double> rows = <double>{};
  for (final Element element in labels.evaluate()) {
    rows.add(tester.getTopLeft(find.byWidget(element.widget)).dy);
  }
  expect(rows.length, 2);
  expect(find.textContaining(RegExp(r'^\+\d+$')), findsOneWidget);
  expect(
      find.descendant(
          of: find.byType(ArticleTags), matching: find.byType(Tooltip)),
      findsNothing);
  final Finder title = find.text(article.title);
  final Finder cover = find.byType(ArticleCover);
  final Finder summary = find.text(article.subtitle);
  expect(tester.getTopLeft(title).dy, lessThan(tester.getTopLeft(cover).dy));
  expect(tester.getTopLeft(summary).dx,
      greaterThan(tester.getBottomRight(cover).dx));
  expect(tester.getSize(cover).width, tester.getSize(cover).height);
  expect(
      tester.getBottomRight(find.text('创作时间未知')).dx,
      closeTo(
          tester.getBottomRight(find.byType(LibraryArticleCard)).dx - 12, .1));
  await tester.tap(find.textContaining(RegExp(r'^\+\d+$')));
  await tester.pumpAndSettle();
  final Finder sheet = find.byType(BottomSheet);
  expect(sheet, findsOneWidget);
  for (final ArticleTopic topic in article.tags) {
    expect(find.descendant(of: sheet, matching: find.text(topic.name)),
        findsOneWidget);
  }
  expect(find.byType(MarkdownArticlePage), findsNothing);
  expect(find.byType(SnackBar), findsNothing);
  Navigator.of(tester.element(sheet)).pop();
  await tester.pumpAndSettle();
  expect(find.byType(BottomSheet), findsNothing);
  expect(find.byType(LibraryArticleCard), findsOneWidget);
  expect(tester.takeException(), isNull);
}

Future<void> testAllCollections(WidgetTester tester) async {
  final LibraryRepository repo = await mount(tester, const Size(360, 800));
  expect(find.text('捷特文库'), findsNothing);
  expect(tester.getTopLeft(find.byType(TextField)).dy,
      lessThan(tester.getTopLeft(find.byType(ColumnizePageView)).dy));
  await tester.tap(find.text('全部专栏（5）'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Flutter 工程'));
  await tester.pumpAndSettle();
  expect(repo.requests.last.groupId, '13');
  expect(tester.takeException(), isNull);
}

Future<LibraryRepository> mount(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  final LibraryRepository repository = LibraryRepository();
  await tester.pumpWidget(MaterialApp(
      home: MultiBlocProvider(providers: <BlocProvider<dynamic>>[
    BlocProvider<ArticleBloc>(
        create: (BuildContext context) => ArticleBloc(repository)..init()),
    BlocProvider<ColumnizeBloc>(
        create: (BuildContext context) =>
            ColumnizeBloc(LibraryCollections())..init()),
  ], child: const Scaffold(body: ArticleLibraryPage()))));
  await tester.pumpAndSettle();
  return repository;
}

Future<void> testCompactSearch(WidgetTester tester) async {
  final LibraryRepository repo = await mount(tester, const Size(360, 800));
  expect(tester.takeException(), isNull);
  expect(find.text('2022-02-17'), findsOneWidget);
  expect(find.text('Canvas'), findsOneWidget);
  await tester.enterText(find.byType(TextField).first, '找不到');
  await tester.pump(const Duration(milliseconds: 200));
  expect(repo.requests.length, 1);
  await tester.pump(const Duration(milliseconds: 200));
  await tester.pumpAndSettle();
  expect(repo.requests.last.query, '找不到');
  expect(find.text('没有匹配的文章，试试其他关键词或主题'), findsOneWidget);
  await tester.tap(find.byTooltip('清空筛选'));
  await tester.pumpAndSettle();
  expect(find.text('Flutter 绘制入门'), findsOneWidget);
  await tester.tap(find.text('Flutter 绘制入门'));
  await settleReaderImages(tester);
  expect(find.text('#Canvas'), findsOneWidget);
  await tester.pageBack();
  await tester.pumpAndSettle();
  expect(find.text('Flutter 绘制入门'), findsOneWidget);
  expect(tester.takeException(), isNull);
}

Future<void> testCollectionNavigation(WidgetTester tester) async {
  final LibraryRepository repo = await mount(tester, const Size(1200, 800));
  expect(find.byType(ColumnizePageView), findsOneWidget);
  final PageView carousel = tester.widget<PageView>(find.byType(PageView));
  final double initialPage = carousel.controller!.page!;
  await tester.drag(find.byType(PageView), const Offset(-540, 0));
  await tester.pumpAndSettle();
  expect(carousel.controller!.page, greaterThan(initialPage));
  await tester.drag(find.byType(PageView), const Offset(540, 0));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Flutter 绘制与动画'));
  await tester.pumpAndSettle();
  expect(repo.requests.last.groupId, '10');
  expect(find.text('从基础图形到交互动画，循序渐进学习。'), findsOneWidget);
  expect(tester.takeException(), isNull);
}

Future<void> testTopics(WidgetTester tester) async {
  final LibraryRepository repo = await mount(tester, const Size(360, 800));
  await tester.tap(find.byType(TopicFilterButton));
  await tester.pumpAndSettle();
  expect(find.byType(BottomSheet), findsOneWidget);
  await tester.tap(find.descendant(
      of: find.byType(TopicOptions), matching: find.text('Canvas')));
  await tester.pumpAndSettle();
  await tester.tap(find.text('应用筛选（1）'));
  await tester.pumpAndSettle();
  expect(repo.requests.last.tagIds, <String>['2']);
  expect(find.byType(Badge), findsOneWidget);
  await tester.tap(find.byTooltip('清空筛选'));
  await tester.pumpAndSettle();
  expect(repo.requests.last.tagIds, isEmpty);
  await tester.tap(find.byIcon(Icons.swap_vert_rounded));
  await tester.pumpAndSettle();
  expect(find.byType(BottomSheet), findsOneWidget);
  await tester.tap(find.text('最早创作'));
  await tester.pumpAndSettle();
  expect(repo.requests.last.sort, 'oldest');
  expect(find.byType(BottomSheet), findsNothing);
  expect(tester.takeException(), isNull);
}

Future<void> testReader(WidgetTester tester) async {
  final LibraryRepository repo = LibraryRepository();
  await tester.pumpWidget(MaterialApp(
      home: MarkdownArticlePage(article: repo.item, repository: repo)));
  await settleReaderImages(tester);
  expect(find.text('#Canvas'), findsOneWidget);
  final ReadingImage image =
      tester.widget<ReadingImage>(find.byType(ReadingImage));
  expect(image.url, 'http://localhost:9602/articles/one/images/path.png');
  expect(find.byTooltip('阅读字号'), findsNothing);
  expect(tester.takeException(), isNull);
}

/// 等待图片真实解码，避免骨架动画使虚拟时钟的 settle 永远等待。
Future<void> settleReaderImages(WidgetTester tester) async {
  await tester.pump();
  Future<void> decode() => precacheImage(
      const CachedNetworkImageProvider(
          'http://localhost:9602/articles/one/images/path.png'),
      tester.element(find.byType(MaterialApp)));
  await tester.runAsync(decode);
  await tester.pumpAndSettle();
}
