import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../bloc/exp.dart';
import '../../data/exp.dart';
import 'column_detail_page.dart';
import '../library/collection_cover.dart';
import '../library/collection_shelf_card.dart';
import '../loading/collection_skeleton.dart';

final DateFormat formatLong = DateFormat('yyyy-MM-dd HH:mm:ss');

/// 顶部专栏书架，等高卡片支持手势和左右箭头浏览。
class ColumnizePageView extends StatefulWidget {
  /// 单张卡片占可视宽度的比例。
  final double fraction;

  /// 宽屏显示两侧翻页按钮，手机通过下一张预览提示横滑。
  final bool showArrows;

  /// 手机使用封面与文字分区的书架卡片。
  final bool shelf;
  const ColumnizePageView(
      {super.key,
      this.fraction = .32,
      this.showArrows = true,
      this.shelf = false});
  @override
  State<ColumnizePageView> createState() => _ColumnizePageViewState();
}

class _ColumnizePageViewState extends State<ColumnizePageView> {
  /// 当前专栏页位置。
  int _position = 0;

  /// 卡片滑动控制器。
  late final PageController _ctrl;

  /// 手机书架的内容滚动位置，包含两端可随内容滑走的留白。
  late final ScrollController _shelfScroll = ScrollController();
  @override
  void initState() {
    super.initState();
    _ctrl = PageController(viewportFraction: widget.fraction);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _shelfScroll.dispose();
    super.dispose();
  }

  void _next() => _move(1);
  void _previous() => _move(-1);
  void _changed(int index) => setState(() => _position = index);

  /// 按钮与拖动共用页位置，并限制在在线目录范围内。
  void _move(int delta) {
    if (_ctrl.positions.length != 1) return;
    final int count = context.read<ColumnizeBloc>().state.data.length;
    final int target = (_position + delta).clamp(0, count - 1);
    _ctrl.animateToPage(target,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    final ColumnizeBloc bloc = context.watch<ColumnizeBloc>();
    if (bloc.state.data.isEmpty) {
      if (bloc.state.loading) {
        return CollectionSkeleton(
            fraction: widget.fraction,
            showArrows: widget.showArrows,
            shelf: widget.shelf);
      }
      return Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Text(bloc.state.error == null ? '暂无专栏' : '专栏加载失败'),
        TextButton(onPressed: bloc.refresh, child: const Text('刷新专栏')),
      ]));
    }
    if (widget.shelf) return LayoutBuilder(builder: _shelf);
    final Widget pages = PageView.builder(
        controller: _ctrl,
        padEnds: false,
        itemCount: bloc.state.data.length,
        itemBuilder: _page,
        onPageChanged: _changed);
    if (!widget.showArrows) return pages;
    return Row(children: <Widget>[
      SizedBox(
          width: 28,
          child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: _previous,
              tooltip: '上一专栏',
              icon: const Icon(Icons.chevron_left, size: 24))),
      const SizedBox(width: 8),
      Expanded(child: pages),
      const SizedBox(width: 8),
      SizedBox(
          width: 28,
          child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: _next,
              tooltip: '下一专栏',
              icon: const Icon(Icons.chevron_right, size: 24))),
    ]);
  }

  /// 边距放在横向列表内容中，滑动时卡片可经过整个屏幕宽度。
  Widget _shelf(BuildContext context, BoxConstraints box) {
    Widget card(BuildContext context, int index) => SizedBox(
        width: box.maxWidth * widget.fraction - 12,
        child: ColumnizeItem(
            columnize: context.read<ColumnizeBloc>().state.data[index],
            index: index,
            shelf: true));
    return ListView.separated(
        key: const PageStorageKey<String>('collection-shelf'),
        controller: _shelfScroll,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: context.read<ColumnizeBloc>().state.data.length,
        separatorBuilder: _shelfGap,
        itemBuilder: card);
  }

  Widget _shelfGap(BuildContext context, int index) =>
      const SizedBox(width: 12);

  Widget _page(BuildContext context, int index) => Padding(
      padding:
          EdgeInsets.only(right: widget.showArrows || widget.shelf ? 12 : 8),
      child: ColumnizeItem(
          columnize: context.read<ColumnizeBloc>().state.data[index],
          index: index,
          shelf: widget.shelf));
}

class ColumnizeItem extends StatelessWidget {
  /// 当前可见专栏的在线元数据。
  final Columnize columnize;

  /// 书架中的位置，用于图标和配色。
  final int index;

  /// 使用手机专栏书架样式。
  final bool shelf;
  const ColumnizeItem(
      {super.key,
      required this.columnize,
      required this.index,
      this.shelf = false});

  /// 专栏独立查询其文章，返回首页后保留首页检索状态。
  static void openCollection(BuildContext context, Columnize columnize) {
    final ArticleRepository repository = context.read<ArticleBloc>().repository;
    final Widget detail = BlocProvider<ArticleBloc>(
        create: (BuildContext context) =>
            ArticleBloc(repository, groupId: columnize.id, pageSize: 100)
              ..init(),
        child: ColumnDetailPage(columnize: columnize));
    Navigator.of(context).push(SlidePageRoute(child: detail));
  }

  @override
  Widget build(BuildContext context) {
    if (shelf) {
      return CollectionShelfCard(
          collection: columnize,
          onTap: () => openCollection(context, columnize));
    }
    final Widget fallback = _fallback(context);
    if (columnize.cover.trim().isEmpty) return fallback;
    return CollectionCover(
        collection: columnize,
        fallback: fallback,
        onTap: () => openCollection(context, columnize));
  }

  Widget _fallback(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final bool dark = colors.brightness == Brightness.dark;
    final bool primary = index == 0;
    final List<Color> accents = <Color>[
      colors.primary,
      const Color(0xff378AE5),
      const Color(0xff7E63DC),
      const Color(0xff259C98)
    ];
    final Color accent = accents[index % accents.length];
    final Color ink = primary ? colors.onPrimary : colors.onSurface;
    final Color muted = primary
        ? colors.onPrimary.withValues(alpha: .85)
        : colors.onSurfaceVariant;
    return Material(
        color: primary
            ? colors.primary
            : Color.alphaBlend(
                accent.withValues(alpha: dark ? .18 : .09), colors.surface),
        borderRadius: BorderRadius.circular(8),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
            onTap: () => openCollection(context, columnize),
            child: Row(children: <Widget>[
              Container(
                  width: 8, color: accent.withValues(alpha: primary ? .6 : .5)),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Icon(_icon,
                                    size: 24,
                                    color:
                                        primary ? colors.onPrimary : accent)),
                            const SizedBox(width: 12),
                            Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                  Text(columnize.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: ink,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14)),
                                  const SizedBox(height: 4),
                                  Text('${columnize.count} 篇',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: primary ? muted : accent)),
                                  const SizedBox(height: 8),
                                  Expanded(
                                      child: Text(columnize.subtitle,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 12,
                                              height: 1.4,
                                              color: muted))),
                                ])),
                          ]))),
            ])));
  }

  IconData get _icon {
    final String title = columnize.title;
    if (title.contains('绘制') || title.contains('动画')) {
      return Icons.brush_outlined;
    }
    if (title.contains('原理') || title.contains('性能')) {
      return Icons.layers_outlined;
    }
    if (title.contains('组件') || title.contains('布局')) {
      return Icons.widgets_outlined;
    }
    if (title.contains('Dart')) return Icons.code;
    return Icons.menu_book_outlined;
  }
}
