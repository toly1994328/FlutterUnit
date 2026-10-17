import 'dart:async';
import 'package:artifact/src/articles/bloc/exp.dart';
import 'package:artifact/src/articles/data/exp.dart';
import 'package:artifact/src/articles/view/library/article_card.dart';
import 'package:artifact/src/articles/view/library/library_page.dart';
import 'package:artifact/src/articles/view/loading/article_skeleton.dart';
import 'package:artifact/src/articles/view/loading/collection_skeleton.dart';
import 'package:artifact/src/articles/view/loading/content_skeleton.dart';
import 'package:artifact/src/articles/view/article/markdown_article_page.dart';
import 'package:artifact/src/articles/view/article/reading/reading_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class PendingArticles extends ArticleRepository {
  /// 测试决定每次网络请求何时成功或失败。
  final List<Completer<ArticlePage>> requests = <Completer<ArticlePage>>[];
  @override
  Future<ArticlePage> query(ArticleFilter filter, {String? cursor}) {
    final Completer<ArticlePage> request = Completer<ArticlePage>();
    requests.add(request);
    return request.future;
  }
}

class PendingCollections extends ColumnizeRepository {
  /// 独立于文章请求控制专栏加载状态。
  final Completer<List<Columnize>> response = Completer<List<Columnize>>();
  @override
  Future<List<Columnize>> query() => response.future;
}

class PendingDocument extends ArticleRepository {
  /// 控制正文加载完成时机，以比较骨架和正文的标题位置。
  final Completer<MarkdownArticle> response = Completer<MarkdownArticle>();
  @override
  Future<MarkdownArticle> openMarkdown(String id) => response.future;
}

void main() {
  testWidgets('慢请求使用卡片骨架，翻页保留原文章，失败后可重试', testPending);
  testWidgets('减少动态效果时骨架停止动画，窄屏深色布局不溢出', testReducedMotion);
  testWidgets('正文加载前后标题四边对齐，顶部栏高度只计入一次', testDocumentInsets);
}

Future<void> testDocumentInsets(WidgetTester tester) async {
  tester.view.devicePixelRatio = 1;
  tester.view.padding = const FakeViewPadding(top: 24);
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetPadding);
  for (final Size size in <Size>[
    const Size(360, 800),
    const Size(700, 900),
    const Size(1200, 900),
  ]) {
    tester.view.physicalSize = size;
    final PendingDocument repository = PendingDocument();
    await tester.pumpWidget(MaterialApp(
        home: MarkdownArticlePage(
            article: const Article(id: 'pending', title: '正文测试', url: ''),
            repository: repository)));
    expect(find.byType(ReadingSkeleton), findsOneWidget);
    final Rect loadingBounds = tester.getRect(find.byType(ReadingHeader));
    final double toolbarBottom = tester.getBottomLeft(find.byType(AppBar)).dy;
    expect(loadingBounds.top - toolbarBottom, closeTo(16, .1));
    repository.response.complete(const MarkdownArticle(
        title: '正文测试',
        content: '加载完成的正文。',
        sourceUrl: 'https://example.com/article'));
    await tester.pumpAndSettle();
    expect(find.byType(ReadingSkeleton), findsNothing);
    final Rect loadedBounds = tester.getRect(find.byType(ReadingHeader));
    expect(loadedBounds.top, closeTo(loadingBounds.top, .1));
    expect(loadedBounds.left, closeTo(loadingBounds.left, .1));
    expect(loadedBounds.right, closeTo(loadingBounds.right, .1));
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
  }
}

Future<void> testPending(WidgetTester tester) async {
  tester.view.physicalSize = const Size(360, 800);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  final PendingArticles articles = PendingArticles();
  final PendingCollections collections = PendingCollections();
  final ArticleBloc bloc = ArticleBloc(articles);
  final ColumnizeBloc columns = ColumnizeBloc(collections);
  unawaited(bloc.init());
  unawaited(columns.init());
  addTearDown(bloc.close);
  addTearDown(columns.close);
  await tester.pumpWidget(MaterialApp(
      home: MultiBlocProvider(providers: <BlocProvider<dynamic>>[
    BlocProvider<ArticleBloc>.value(value: bloc),
    BlocProvider<ColumnizeBloc>.value(value: columns),
  ], child: const Scaffold(body: ArticleLibraryPage()))));
  await tester.pump(const Duration(milliseconds: 300));
  expect(find.byType(ArticleSkeleton), findsOneWidget);
  expect(find.byType(CollectionSkeleton), findsOneWidget);
  expect(find.byType(CircularProgressIndicator), findsNothing);
  expect(tester.takeException(), isNull);
  collections.response.completeError(StateError('专栏离线'));
  articles.requests.first.complete(const ArticlePage(
      items: <Article>[Article(id: '1', title: '已加载的文章', url: '')],
      total: 2,
      nextCursor: 'next'));
  await tester.pumpAndSettle();
  expect(find.byType(CollectionSkeleton), findsNothing);
  expect(find.text('专栏加载失败'), findsOneWidget);
  expect(find.byType(ArticleSkeleton), findsNothing);
  final Future<void> next = bloc.loadNextPageMore();
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 16));
  expect(find.byType(LibraryArticleCard), findsOneWidget);
  expect(tester.widget<ArticleSkeleton>(find.byType(ArticleSkeleton)).append,
      isTrue);
  articles.requests.last.completeError(StateError('文章离线'));
  await next;
  await tester.pumpAndSettle();
  expect(find.byType(ArticleSkeleton), findsNothing);
  expect(find.text('文章加载失败，已加载的内容仍可阅读'), findsOneWidget);
  expect(find.byType(LibraryArticleCard), findsOneWidget);
  await tester.tap(find.text('重试'));
  await tester.pump();
  articles.requests.last.complete(const ArticlePage(
      items: <Article>[Article(id: '2', title: '新一页的文章', url: '')], total: 2));
  await tester.pumpAndSettle();
  expect(find.byType(LibraryArticleCard), findsNWidgets(2));
  expect(find.byType(ArticleSkeleton), findsNothing);
  expect(tester.takeException(), isNull);
}

Future<void> testReducedMotion(WidgetTester tester) async {
  tester.view.physicalSize = const Size(320, 720);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  final SemanticsHandle semantics = tester.ensureSemantics();
  await tester.pumpWidget(MaterialApp(
      theme: ThemeData.dark(),
      home: const MediaQuery(
          data: MediaQueryData(disableAnimations: true),
          child: Scaffold(
              body: CustomScrollView(slivers: <Widget>[
            ArticleSkeleton(flat: true),
          ])))));
  await tester.pumpAndSettle();
  expect(tester.hasRunningAnimations, isFalse);
  expect(find.bySemanticsLabel('正在加载文章'), findsOneWidget);
  expect(tester.takeException(), isNull);
  semantics.dispose();
  await tester.pumpWidget(const SizedBox.shrink());
  expect(tester.takeException(), isNull);
}
