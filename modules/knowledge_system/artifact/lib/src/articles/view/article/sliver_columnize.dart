import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/exp.dart';
import '../../data/exp.dart';
import '../library/collection_picker.dart';
import '../library/collection_shelf_card.dart';
import 'columnize_page_view.dart';

/// 独立的专栏书架面板，按空间显示多张卡片和下一张预览。
class ColumnizeViewPage extends StatelessWidget {
  const ColumnizeViewPage({super.key});
  @override
  Widget build(BuildContext context) => LayoutBuilder(builder: _layout);

  /// 展示当前在线目录中的全部专栏，选择后进入独立文章列表。
  Future<void> _all(BuildContext context) async {
    final List<Columnize> items = context.read<ColumnizeBloc>().state.data;
    if (items.isEmpty) return;
    Widget picker(BuildContext context) => CollectionPicker(items: items);
    final Columnize? selected =
        await showDialog<Columnize>(context: context, builder: picker);
    if (!context.mounted || selected == null) return;
    ColumnizeItem.openCollection(context, selected);
  }

  /// 未取得数量时不闪现“0 个专栏”。
  String _allLabel(BuildContext context) {
    final int count = context.watch<ColumnizeBloc>().state.data.length;
    return count == 0 ? '全部专栏' : '全部专栏（$count）';
  }

  Widget _layout(BuildContext context, BoxConstraints box) {
    final bool compact = box.maxWidth < 540;
    if (compact) return _mobileShelf(context, box);
    final double fraction = box.maxWidth >= 680
        ? 1 / 3.1
        : box.maxWidth >= 540
            ? 1 / 2.1
            : .9;
    // 手机露出下一张卡片提示横滑，宽屏另外保留两侧箭头。
    final double viewportWidth = box.maxWidth - 24 - (compact ? 0 : 72);
    final double cardWidth = viewportWidth * fraction - (compact ? 8 : 12);
    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).listTileTheme.tileColor ??
                Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(children: <Widget>[
                    const Expanded(
                        child: Text('文章专栏',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700))),
                    TextButton.icon(
                        onPressed: () => _all(context),
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            minimumSize: const Size(0, 32),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            textStyle:
                                const TextStyle(fontSize: 13, height: 1.25)),
                        label: Text(_allLabel(context)),
                        icon: const Icon(Icons.chevron_right, size: 16),
                        iconAlignment: IconAlignment.end),
                  ])),
              const SizedBox(height: 8),
              SizedBox(
                  height: cardWidth * 9 / 16,
                  child: ColumnizePageView(
                      key: ValueKey<double>(fraction),
                      fraction: fraction,
                      showArrows: !compact)),
            ]));
  }

  /// 手机滑动视口贯穿屏幕，仅标题保留与搜索栏对齐的文字边距。
  Widget _mobileShelf(BuildContext context, BoxConstraints box) {
    const double fraction = .72;
    final double coverWidth = box.maxWidth * fraction - 12;
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(children: <Widget>[
                const Expanded(
                    child: Text('文章专栏',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700))),
                TextButton.icon(
                    onPressed: () => _all(context),
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        minimumSize: const Size(0, 32),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        textStyle: const TextStyle(fontSize: 13)),
                    iconAlignment: IconAlignment.end,
                    icon: const Icon(Icons.chevron_right, size: 18),
                    label: Text(_allLabel(context))),
              ])),
          const SizedBox(height: 12),
          SizedBox(
              height: coverWidth / CollectionShelfCard.coverAspectRatio +
                  CollectionShelfCard.footerHeight(context,
                      context.watch<ColumnizeBloc>().state.data, coverWidth),
              child: const ColumnizePageView(
                  key: ValueKey<String>('mobile-collection-shelf'),
                  fraction: fraction,
                  showArrows: false,
                  shelf: true)),
        ]);
  }
}
