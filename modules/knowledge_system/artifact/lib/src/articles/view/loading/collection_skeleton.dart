import 'package:flutter/material.dart';
import 'skeleton_loading.dart';
import '../library/collection_shelf_card.dart';

/// 专栏保留真实封面比例和下一张露出，避免请求完成后书架突然变高。
class CollectionSkeleton extends StatelessWidget {
  /// 与专栏翻页视图使用同一宽度比例。
  final double fraction;

  /// 桌面两侧为原有翻页按钮保留位置。
  final bool showArrows;

  /// 手机骨架包含独立的白色说明区。
  final bool shelf;
  const CollectionSkeleton(
      {super.key,
      required this.fraction,
      required this.showArrows,
      required this.shelf});
  @override
  Widget build(BuildContext context) => SkeletonLoading(
      label: '正在加载专栏',
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: showArrows ? 36 : 0),
          child: LayoutBuilder(builder: _layout)));

  Widget _layout(BuildContext context, BoxConstraints box) {
    if (shelf) {
      Widget card(BuildContext context, int index) => SizedBox(
          width: box.maxWidth * fraction - 12, child: _card(context, index));
      return ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 4,
          separatorBuilder: _gap,
          itemBuilder: card);
    }
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemExtent: box.maxWidth * fraction,
        itemCount: 4,
        itemBuilder: _card);
  }

  Widget _gap(BuildContext context, int index) => const SizedBox(width: 12);

  Widget _card(BuildContext context, int index) => Padding(
      padding: EdgeInsets.only(right: shelf ? 0 : 12),
      child: !shelf
          ? const SkeletonBlock(height: double.infinity, radius: 8)
          : DecoratedBox(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        AspectRatio(
                            aspectRatio: CollectionShelfCard.coverAspectRatio,
                            child: SkeletonBlock(height: double.infinity)),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SkeletonBlock(width: 144, height: 14),
                                  SizedBox(height: 8),
                                  SkeletonBlock(height: 10),
                                  SizedBox(height: 6),
                                  SkeletonBlock(width: 100, height: 10),
                                ])),
                      ]))));
}
