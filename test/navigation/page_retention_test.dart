import 'package:artifact/src/articles/bloc/exp.dart';
import 'package:artifact/src/articles/data/exp.dart';
import 'package:artifact/src/articles/view/library/library_page.dart';
import 'package:artifact/src/articles/view/article/columnize_page_view.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class CountingArticles extends ArticleRepository {
  /// 记录首次加载与用户主动搜索，切换页面不应增加请求。
  final List<ArticleFilter> requests = <ArticleFilter>[];
  @override
  Future<ArticlePage> query(ArticleFilter filter, {String? cursor}) async {
    requests.add(filter);
    return ArticlePage(total: 30, items: List<Article>.generate(30, _article));
  }

  Article _article(int index) => Article(
      id: '$index',
      title: 'Flutter 文章 $index',
      subtitle: '用于确认切换入口后仍保留搜索条件与列表滚动位置。',
      url: '');
}

class CountingCollections extends ColumnizeRepository {
  /// 专栏只在首次进入时请求。
  int requests = 0;
  @override
  Future<List<Columnize>> query() async {
    requests++;
    return List<Columnize>.generate(5, _collection);
  }

  Columnize _collection(int index) =>
      Columnize(id: '$index', title: '专栏 $index', subtitle: '专栏说明', count: 6);
}

/// 用与客户端相同的两层分页验证真实文库的状态，不依赖测试服务。
class RetentionHarness extends StatelessWidget {
  /// 底部页面的跳转控制器。
  final PageController outer;

  /// 底部当前选中的入口。
  final ValueNotifier<int> selected;

  /// 知识模块内部四个标签。
  final TabController inner;

  /// 用于验证文章是否重复请求的 Bloc 仓储。
  final CountingArticles articles;

  /// 用于验证专栏是否重复请求的 Bloc 仓储。
  final CountingCollections collections;
  const RetentionHarness(
      {super.key,
      required this.outer,
      required this.selected,
      required this.inner,
      required this.articles,
      required this.collections});

  @override
  Widget build(BuildContext context) => MaterialApp(
      home: Scaffold(
          body: ValueListenableBuilder<int>(
              valueListenable: selected, builder: _outerPages)));

  Widget _outerPages(BuildContext context, int value, Widget? child) =>
      PageView(controller: outer, children: <Widget>[
        for (int index = 0; index < 5; index++)
          RetainedPage(
              active: value == index,
              child: index == 1 ? _knowledge() : Text('入口 $index')),
      ]);

  Widget _knowledge() => MultiBlocProvider(providers: <BlocProvider<dynamic>>[
        BlocProvider<ArticleBloc>(create: _articles),
        BlocProvider<ColumnizeBloc>(create: _collections),
      ], child: ListenableBuilder(listenable: inner, builder: _innerPages));

  ArticleBloc _articles(BuildContext context) => ArticleBloc(articles)..init();
  ColumnizeBloc _collections(BuildContext context) =>
      ColumnizeBloc(collections)..init();

  Widget _innerPages(BuildContext context, Widget? child) =>
      TabBarView(controller: inner, children: <Widget>[
        for (int index = 0; index < 4; index++)
          RetainedPage(
              active: inner.index == index,
              child: index == 0
                  ? const ArticleLibraryPage()
                  : Text('知识标签 $index')),
      ]);
}

void main() {
  testWidgets('跨底部入口和知识标签保留搜索、滚动及专栏位置，且不重复请求', testRetention);
}

Future<void> testRetention(WidgetTester tester) async {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  final PageController outer = PageController();
  final ValueNotifier<int> selected = ValueNotifier<int>(0);
  final TabController inner = TabController(length: 4, vsync: tester);
  final CountingArticles articles = CountingArticles();
  final CountingCollections collections = CountingCollections();
  await tester.pumpWidget(RetentionHarness(
      outer: outer,
      selected: selected,
      inner: inner,
      articles: articles,
      collections: collections));
  await tester.pumpAndSettle();
  expect(articles.requests, isEmpty);
  selected.value = 1;
  outer.jumpToPage(1);
  await tester.pumpAndSettle();
  expect(articles.requests.length, 1);
  await tester.enterText(find.byType(TextField).first, 'Flutter');
  await tester.pump(const Duration(milliseconds: 400));
  await tester.pumpAndSettle();
  expect(articles.requests.length, 2);
  final ListView shelf = tester.widget<ListView>(find.descendant(
      of: find.byType(ColumnizePageView), matching: find.byType(ListView)));
  shelf.controller!.jumpTo(400);
  final CustomScrollView list = tester.widget(find.byType(CustomScrollView));
  list.controller!.jumpTo(500);
  await tester.pumpAndSettle();
  final double offset = list.controller!.offset;
  inner.animateTo(3);
  await tester.pumpAndSettle();
  expect(find.text('知识标签 3'), findsOneWidget);
  selected.value = 4;
  outer.jumpToPage(4);
  await tester.pumpAndSettle();
  final BuildContext retainedLibrary =
      tester.element(find.byType(ArticleLibraryPage, skipOffstage: false));
  expect(TickerMode.valuesOf(retainedLibrary).enabled, isFalse);
  selected.value = 1;
  outer.jumpToPage(1);
  await tester.pumpAndSettle();
  expect(inner.index, 3);
  inner.animateTo(0);
  await tester.pumpAndSettle();
  final PageView knowledgePages = tester.widget<PageView>(find
      .descendant(of: find.byType(TabBarView), matching: find.byType(PageView))
      .first);
  expect(knowledgePages.controller!.page, closeTo(0, .01));
  final TextField search =
      tester.widget(find.byType(TextField, skipOffstage: false).first);
  expect(search.controller!.text, 'Flutter');
  expect(list.controller!.offset, closeTo(offset, .1));
  expect(shelf.controller!.offset, closeTo(400, .01));
  expect(TickerMode.valuesOf(retainedLibrary).enabled, isTrue);
  expect(articles.requests.length, 2);
  expect(collections.requests, 1);
  expect(tester.takeException(), isNull);
  await tester.pumpWidget(const SizedBox.shrink());
  outer.dispose();
  selected.dispose();
  inner.dispose();
}
