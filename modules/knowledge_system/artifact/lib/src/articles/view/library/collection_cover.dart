import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../data/exp.dart';
import '../../env/artifact_env.dart';
import 'collection_cover_url.dart';
import '../loading/skeleton_loading.dart';

/// 专栏插画铺满卡片，业务文字独立覆盖，图片不可用时使用原有卡片。
class CollectionCover extends StatelessWidget {
  /// 在线封面、标题、简介及文章数量。
  final Columnize collection;

  /// 未加载或图片失败时展示的原有卡片。
  final Widget fallback;

  /// 进入专栏文章列表。
  final VoidCallback onTap;

  const CollectionCover(
      {super.key,
      required this.collection,
      required this.fallback,
      required this.onTap});

  @override
  Widget build(BuildContext context) => LayoutBuilder(builder: _layout);

  /// 只在请求层适配物理像素，数据库和专栏元数据继续保存原图地址。
  Widget _layout(BuildContext context, BoxConstraints box) => ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image(
            image: CachedNetworkImageProvider(collectionCoverUrl(
                ArtifactEnv().resolveResource(collection.cover),
                logicalWidth: box.maxWidth,
                pixelRatio: MediaQuery.devicePixelRatioOf(context))),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            excludeFromSemantics: true,
            frameBuilder: _frame,
            errorBuilder: _error),
      );

  Widget _error(BuildContext context, Object error, StackTrace? stack) =>
      fallback;

  Widget _frame(
      BuildContext context, Widget image, int? frame, bool synchronous) {
    if (!synchronous && frame == null) {
      return const SkeletonLoading(
          label: '正在加载专栏封面',
          child: SkeletonBlock(height: double.infinity, radius: 8));
    }
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Stack(fit: StackFit.expand, children: <Widget>[
      image,
      Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
              padding: const EdgeInsets.fromLTRB(12, 24, 12, 10),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                    colors.surface.withValues(alpha: 0),
                    colors.surface.withValues(alpha: .94),
                    colors.surface
                  ],
                      stops: const <double>[
                    0,
                    .5,
                    1
                  ])),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(collection.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: colors.onSurface)),
                    if (collection.subtitle.isNotEmpty) ...<Widget>[
                      const SizedBox(height: 4),
                      Text(collection.subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 11, color: colors.onSurfaceVariant)),
                    ],
                  ]))),
      Positioned(
          top: 8,
          right: 8,
          child: DecoratedBox(
              decoration: BoxDecoration(
                  color: colors.surface.withValues(alpha: .92),
                  borderRadius: BorderRadius.circular(6)),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text('${collection.count} 篇',
                      style: TextStyle(
                          fontSize: 11, color: colors.onSurfaceVariant))))),
      Positioned.fill(
          child: Material(
              color: Colors.transparent,
              child: InkWell(
                  onTap: onTap, borderRadius: BorderRadius.circular(8)))),
    ]);
  }
}
