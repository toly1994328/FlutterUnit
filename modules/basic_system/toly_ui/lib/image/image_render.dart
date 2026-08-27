import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'file_image_provider_stub.dart'
    if (dart.library.io) 'file_image_provider_io.dart';

/// 图片占位组件构建器。
typedef ImageRenderPlaceholderBuilder = Widget Function(BuildContext context);

/// 图片错误组件构建器。
typedef ImageRenderErrorBuilder = Widget Function(
  BuildContext context,
  Object error,
);

/// 图片资源类型。
enum ImageRenderSourceType {
  /// 根据资源地址自动识别。
  auto,

  /// HTTP 或 HTTPS 网络图片。
  network,

  /// Flutter 资产图片。
  asset,

  /// 本机文件图片。
  file,
}

/// 统一的图片渲染入口。
class ImageRender extends StatelessWidget {
  const ImageRender({
    super.key,
    required this.source,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.cacheWidth,
    this.cacheHeight,
    this.sourceType = ImageRenderSourceType.auto,
    this.assetPackage,
    this.placeholderBuilder,
    this.errorBuilder,
  });

  /// 图片资源地址。
  final String source;

  /// 图片组件的布局宽度。
  final double? width;

  /// 图片组件的布局高度。
  final double? height;

  /// 图片在布局区域中的适配方式。
  final BoxFit fit;

  /// 图片在布局区域中的对齐方式。
  final Alignment alignment;

  /// 内存缓存使用的目标像素宽度。
  final int? cacheWidth;

  /// 内存缓存使用的目标像素高度。
  final int? cacheHeight;

  /// 图片资源类型，默认根据地址自动识别。
  final ImageRenderSourceType sourceType;

  /// 资产所属的 Flutter 包名。
  final String? assetPackage;

  /// 图片加载期间的占位组件构建器。
  final ImageRenderPlaceholderBuilder? placeholderBuilder;

  /// 图片加载失败时的组件构建器。
  final ImageRenderErrorBuilder? errorBuilder;

  @override
  Widget build(BuildContext context) {
    final ImageRenderSourceType effectiveType = resolveSourceType(source);
    switch (effectiveType) {
      case ImageRenderSourceType.network:
        return _buildNetworkImage();
      case ImageRenderSourceType.asset:
        return _buildAssetImage();
      case ImageRenderSourceType.file:
        return _buildFileImage();
      case ImageRenderSourceType.auto:
        throw StateError('自动识别后不应保留 auto 图片类型');
    }
  }

  /// 根据显式配置或资源地址确定图片类型。
  ImageRenderSourceType resolveSourceType(String location) {
    if (sourceType != ImageRenderSourceType.auto) {
      return sourceType;
    }
    final Uri? uri = Uri.tryParse(location);
    if (uri?.scheme == 'http' || uri?.scheme == 'https') {
      return ImageRenderSourceType.network;
    }
    final bool isWindowsPath = RegExp(r'^[a-zA-Z]:[\\/]').hasMatch(location);
    final bool isUncPath = location.startsWith(r'\\');
    if (uri?.scheme == 'file' ||
        location.startsWith('/') ||
        isWindowsPath ||
        isUncPath) {
      return ImageRenderSourceType.file;
    }
    return ImageRenderSourceType.asset;
  }

  Widget _buildNetworkImage() {
    return CachedNetworkImage(
      imageUrl: source,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      memCacheWidth: cacheWidth,
      memCacheHeight: cacheHeight,
      placeholder: _buildPlaceholder,
      errorWidget: _buildError,
    );
  }

  Widget _buildAssetImage() {
    final String assetName = source.startsWith('asset://')
        ? source.substring('asset://'.length)
        : source;
    final AssetImage provider = AssetImage(assetName, package: assetPackage);
    return _buildProviderImage(provider);
  }

  Widget _buildFileImage() {
    final String filePath =
        source.startsWith('file://') ? Uri.parse(source).toFilePath() : source;
    final ImageProvider<Object> provider = createFileImageProvider(filePath);
    return _buildProviderImage(provider);
  }

  Widget _buildProviderImage(ImageProvider<Object> provider) {
    final ImageProvider<Object> resizedProvider = ResizeImage.resizeIfNeeded(
      cacheWidth,
      cacheHeight,
      provider,
    );
    return Image(
      image: resizedProvider,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      frameBuilder: _buildFrame,
      errorBuilder: _buildProviderError,
    );
  }

  Widget _buildFrame(
    BuildContext context,
    Widget child,
    int? frame,
    bool wasSynchronouslyLoaded,
  ) {
    if (wasSynchronouslyLoaded || frame != null) {
      return child;
    }
    return _buildPlaceholder(context, source);
  }

  Widget _buildProviderError(
    BuildContext context,
    Object error,
    StackTrace? _,
  ) {
    return _buildError(context, source, error);
  }

  Widget _buildPlaceholder(BuildContext context, String _) {
    return placeholderBuilder?.call(context) ??
        ColoredBox(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
        );
  }

  Widget _buildError(BuildContext context, String _, Object error) {
    return errorBuilder?.call(context, error) ??
        ColoredBox(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: const Center(child: Icon(Icons.broken_image_outlined)),
        );
  }
}
