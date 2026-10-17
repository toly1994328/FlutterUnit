import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/exp.dart';
import '../../data/exp.dart';
import 'article_grid.dart';
import 'library_controller.dart';
import 'library_controls.dart';
import '../article/sliver_columnize.dart';
import '../loading/article_skeleton.dart';
import '../loading/skeleton_loading.dart';

/// 全部文库与专栏详情共用在线检索、筛选和分页体验。
class ArticleBrowser extends StatefulWidget {
  /// 专栏详情中的说明，文库主页为空。
  final Columnize? collection;

  /// 文库首页在文章上方显示原有横向专栏。
  final bool showCollections;

  /// 手机主页从外部顶部栏操作同一个检索控制器。
  final LibraryController? controller;

  /// 独立文库和专栏页保留内置工具栏，手机主页将其移到顶部。
  final bool showToolbar;
  const ArticleBrowser(
      {super.key,
      this.collection,
      this.showCollections = false,
      this.controller,
      this.showToolbar = true});
  @override
  State<ArticleBrowser> createState() => _ArticleBrowserState();
}

class _ArticleBrowserState extends State<ArticleBrowser> {
  /// 未注入时由当前页面持有，注入时沿用顶部栏的状态。
  late final LibraryController _controls;

  /// 列表位置，切换筛选时回到开头。
  final ScrollController _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _controls =
        widget.controller ?? LibraryController(context.read<ArticleBloc>());
  }

  @override
  void dispose() {
    if (widget.controller == null) _controls.dispose();
    _scroll.dispose();
    super.dispose();
  }

  /// 新搜索回到列表顶部，翻页加载继续保持当前位置。
  bool _newQuery(ArticleState previous, ArticleState current) =>
      current is ArticleLoading && current.data.isEmpty;

  void _resetScroll(BuildContext context, ArticleState state) {
    if (_scroll.hasClients) _scroll.jumpTo(0);
  }

  /// 接近列表末端自动翻页；失败后等待显式重试，避免循环请求。
  bool _onScroll(ScrollNotification notification) {
    final ArticleBloc bloc = context.read<ArticleBloc>();
    if (notification.metrics.axis == Axis.vertical &&
        notification.metrics.extentAfter < 300 &&
        bloc.state is ArticleWithData) {
      unawaited(bloc.loadNextPageMore());
    }
    return false;
  }

  @override
  Widget build(BuildContext context) => BlocListener<ArticleBloc, ArticleState>(
      listenWhen: _newQuery,
      listener: _resetScroll,
      child: ListenableBuilder(listenable: _controls, builder: _browser));

  Widget _browser(BuildContext context, Widget? child) =>
      LayoutBuilder(builder: _layout);

  /// 统一文库页边距和分区节奏，文章列数由实际可用宽度决定。
  Widget _layout(BuildContext context, BoxConstraints box) {
    final ArticleBloc bloc = context.watch<ArticleBloc>();
    final ColorScheme colors = Theme.of(context).colorScheme;
    final bool compact = box.maxWidth < 600;
    final double gutter = compact ? 16 : 24;
    final Color background = colors.brightness == Brightness.light
        ? (compact ? const Color(0xffF4F8FC) : const Color(0xffF2F4F8))
        : colors.surfaceContainer;
    return ColoredBox(
        color: background,
        child: NotificationListener<ScrollNotification>(
          onNotification: _onScroll,
          child: RefreshIndicator(
              onRefresh: _refreshAll,
              child: CustomScrollView(
                key: PageStorageKey<String>(
                    'article-browser:${widget.collection?.id ?? 'library'}'),
                controller: _scroll,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: <Widget>[
                  if (widget.showToolbar)
                    SliverPadding(
                        padding: EdgeInsets.fromLTRB(
                            gutter, 16, gutter, compact ? 20 : 14),
                        sliver: SliverToBoxAdapter(
                            child: LibraryControls(
                                controller: _controls, compact: compact))),
                  if (!widget.showToolbar)
                    const SliverToBoxAdapter(child: SizedBox(height: 8)),
                  if (widget.showCollections)
                    SliverPadding(
                        padding: EdgeInsets.fromLTRB(compact ? 0 : gutter, 0,
                            compact ? 0 : gutter, compact ? 16 : 14),
                        sliver: const SliverToBoxAdapter(
                            child: ColumnizeViewPage())),
                  if (widget.collection != null)
                    SliverToBoxAdapter(child: _collectionHeader(context)),
                  if (widget.collection != null ||
                      _controls.tags.isNotEmpty ||
                      _controls.search.text.isNotEmpty)
                    SliverPadding(
                        padding: EdgeInsets.fromLTRB(gutter, 0, gutter, 12),
                        sliver: SliverToBoxAdapter(
                            child: bloc.state is ArticleLoading &&
                                    bloc.state.data.isEmpty
                                ? const Align(
                                    alignment: Alignment.centerLeft,
                                    child: SkeletonLoading(
                                        label: '正在统计文章',
                                        child: SkeletonBlock(width: 96)))
                                : Text('共 ${bloc.total} 篇文章',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: colors.onSurfaceVariant)))),
                  SliverPadding(
                      padding: EdgeInsets.symmetric(
                          horizontal: compact ? 0 : gutter),
                      sliver: _articles(context, flat: compact)),
                  if (bloc.state is! ArticleLoading)
                    SliverToBoxAdapter(
                        child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: _footer(bloc))),
                ],
              )),
        ));
  }

  /// 下拉刷新同步更新专栏和当前文章查询。
  Future<void> _refreshAll() async {
    if (widget.showCollections) await context.read<ColumnizeBloc>().refresh();
    if (!mounted) return;
    await _controls.apply();
  }

  Widget _collectionHeader(BuildContext context) => Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Text(widget.collection!.subtitle,
          style: TextStyle(
              fontSize: 15,
              height: 1.6,
              color: Theme.of(context).colorScheme.onSurfaceVariant)));

  /// 随窗口宽度自动换列，卡片按真实内容占高。
  Widget _articles(BuildContext context, {required bool flat}) {
    final ArticleBloc bloc = context.read<ArticleBloc>();
    return SliverMainAxisGroup(slivers: <Widget>[
      if (bloc.state.data.isNotEmpty)
        LibraryArticleGrid(
            flat: flat, articles: bloc.state.data, repository: bloc.repository),
      if (bloc.state is ArticleLoading)
        ArticleSkeleton(flat: flat, append: bloc.state.data.isNotEmpty),
    ]);
  }

  Widget _footer(ArticleBloc bloc) {
    if (bloc.state is ArticleFailed) {
      return Column(children: <Widget>[
        const Text('文章加载失败，已加载的内容仍可阅读'),
        TextButton(onPressed: bloc.retry, child: const Text('重试')),
      ]);
    }
    if (bloc.state.data.isEmpty) {
      return Column(children: <Widget>[
        const Icon(Icons.search_off, size: 40),
        const SizedBox(height: 12),
        const Text('没有匹配的文章，试试其他关键词或主题'),
        TextButton(onPressed: _controls.reset, child: const Text('清空筛选')),
      ]);
    }
    return Column(children: <Widget>[
      Text('已加载 ${bloc.state.data.length} / ${bloc.total} 篇'),
      if (bloc.hasMore)
        TextButton(onPressed: bloc.loadNextPageMore, child: const Text('加载更多')),
      if (!bloc.hasMore)
        const Padding(padding: EdgeInsets.only(top: 8), child: Text('已浏览全部结果')),
    ]);
  }
}
