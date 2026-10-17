import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'skeleton_loading.dart';

/// 首屏和翻页使用相同文章骨架，宽屏按真实网格最大宽度换列。
class ArticleSkeleton extends StatelessWidget {
  /// 手机使用连续白底列表，桌面使用独立卡片。
  final bool flat;

  /// 翻页只追加一行，首屏预留多行内容。
  final bool append;
  const ArticleSkeleton({super.key, required this.flat, this.append = false});
  @override
  Widget build(BuildContext context) => SliverLayoutBuilder(builder: _layout);

  Widget _layout(BuildContext context, SliverConstraints constraints) {
    final int columns = flat
        ? 1
        : math.max(1, ((constraints.crossAxisExtent + 12) / 412).ceil());
    final int rows = append ? 1 : (flat ? 3 : 2);
    return SliverToBoxAdapter(
        child: SkeletonLoading(
            label: append ? '正在加载更多文章' : '正在加载文章',
            child: Column(children: <Widget>[
              for (int row = 0; row < rows; row++)
                Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          for (int column = 0;
                              column < columns;
                              column++) ...<Widget>[
                            if (column > 0) const SizedBox(width: 12),
                            Expanded(child: _ArticleSkeletonCard(flat: flat)),
                          ],
                        ])),
            ])));
  }
}

class _ArticleSkeletonCard extends StatelessWidget {
  /// 与手机和桌面的实际卡片边距保持一致。
  final bool flat;
  const _ArticleSkeletonCard({required this.flat});
  @override
  Widget build(BuildContext context) => DecoratedBox(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(flat ? 0 : 10)),
      child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: flat ? 16 : 12, vertical: 12),
          child: LayoutBuilder(builder: _content)));

  Widget _content(BuildContext context, BoxConstraints box) {
    final double cover = flat
        ? (box.maxWidth * .28).clamp(88, 96)
        : (box.maxWidth * .3).clamp(72, 112);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FractionallySizedBox(
              widthFactor: .88, child: SkeletonBlock(height: flat ? 18 : 16)),
          const SizedBox(height: 8),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            SkeletonBlock(width: cover, height: cover, radius: 8),
            const SizedBox(width: 12),
            Expanded(
                child: SizedBox(
                    height: cover,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SkeletonBlock(),
                          const SizedBox(height: 8),
                          const FractionallySizedBox(
                              widthFactor: .72, child: SkeletonBlock()),
                          const SizedBox(height: 12),
                          const Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: <Widget>[
                                SkeletonBlock(width: 44, height: 20),
                                SkeletonBlock(width: 32, height: 20),
                              ]),
                          if (flat) ...<Widget>[
                            const SizedBox(height: 8),
                            const Align(
                                alignment: Alignment.centerRight,
                                child: SkeletonBlock(width: 128, height: 10)),
                          ],
                        ]))),
          ]),
          if (!flat) ...<Widget>[
            const SizedBox(height: 8),
            const Align(
                alignment: Alignment.centerRight,
                child: SkeletonBlock(width: 128, height: 10)),
          ],
        ]);
  }
}
