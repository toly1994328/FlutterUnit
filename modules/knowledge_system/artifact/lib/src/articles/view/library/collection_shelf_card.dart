import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../data/exp.dart';
import '../../env/artifact_env.dart';
import 'collection_cover_url.dart';
import '../loading/skeleton_loading.dart';

/// 手机专栏书架将封面与说明分开，保持插画完整、文字清晰。
class CollectionShelfCard extends StatelessWidget {
  /// 手机封面比原 16:9 降低约两成高度，书架与骨架共用比例。
  static const double coverAspectRatio = 20 / 9;

  /// 专栏的在线封面、简介和文章数量。
  final Columnize collection;

  /// 点击后进入该专栏。
  final VoidCallback onTap;
  const CollectionShelfCard(
      {super.key, required this.collection, required this.onTap});

  /// 给两行简介预留空间，随系统文字缩放同步增长。
  static double footerHeight(
      BuildContext context, List<Columnize> collections, double width) {
    if (collections.isEmpty) {
      final TextScaler scaler = MediaQuery.textScalerOf(context);
      return (26 + scaler.scale(14) * 1.4 + scaler.scale(12) * 2.8)
          .ceilToDouble();
    }
    final TextStyle base = Theme.of(context).textTheme.bodyMedium!;
    final TextPainter painter = TextPainter(
        textDirection: Directionality.of(context),
        textScaler: MediaQuery.textScalerOf(context),
        ellipsis: '…');
    double height = 0;
    // 用真实内容测量中英文混排的字形高度，与 Material 的默认字体保持一致。
    for (final Columnize collection in collections) {
      painter.maxLines = 1;
      painter.text = TextSpan(
          text: collection.title,
          style: base.copyWith(
              fontSize: 14, height: 1.4, fontWeight: FontWeight.w600));
      painter.layout(maxWidth: width - 20);
      final double titleHeight = painter.height;
      painter.maxLines = 2;
      painter.text = TextSpan(
          text: collection.subtitle,
          style: base.copyWith(fontSize: 12, height: 1.4));
      painter.layout(maxWidth: width - 20);
      final double measured = 20 + titleHeight + 6 + painter.height;
      if (measured > height) height = measured;
    }
    painter.dispose();
    return height.ceilToDouble();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Material(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
            onTap: onTap,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  AspectRatio(
                      aspectRatio: coverAspectRatio,
                      child: Stack(fit: StackFit.expand, children: <Widget>[
                        LayoutBuilder(builder: _image),
                        Positioned(
                            top: 8,
                            right: 8,
                            child: DecoratedBox(
                                decoration: BoxDecoration(
                                    color:
                                        colors.surface.withValues(alpha: .94),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: Text('${collection.count} 篇',
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: colors.onSurfaceVariant))))),
                      ])),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(collection.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 14,
                                    height: 1.4,
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(height: 6),
                            Text(collection.subtitle,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 12,
                                    height: 1.4,
                                    color: colors.onSurfaceVariant)),
                          ])),
                ])));
  }

  Widget _image(BuildContext context, BoxConstraints box) {
    if (collection.cover.isEmpty) return _placeholder(context);
    return Image(
        image: CachedNetworkImageProvider(collectionCoverUrl(
            ArtifactEnv().resolveResource(collection.cover),
            logicalWidth: box.maxWidth,
            pixelRatio: MediaQuery.devicePixelRatioOf(context))),
        fit: BoxFit.cover,
        excludeFromSemantics: true,
        frameBuilder: _frame,
        errorBuilder: _error);
  }

  Widget _frame(
          BuildContext context, Widget image, int? frame, bool synchronous) =>
      synchronous || frame != null
          ? image
          : const SkeletonLoading(
              label: '正在加载专栏封面', child: SkeletonBlock(height: double.infinity));
  Widget _error(BuildContext context, Object error, StackTrace? stack) =>
      _placeholder(context);
  Widget _placeholder(BuildContext context) => ColoredBox(
      color: Theme.of(context).colorScheme.primary.withValues(alpha: .05),
      child: Icon(Icons.menu_book_outlined,
          color: Theme.of(context).colorScheme.primary.withValues(alpha: .35)));
}
