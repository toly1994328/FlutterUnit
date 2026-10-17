import 'dart:math' as math;

/// 正文预览使用屏幕像素比减一、最低一倍分档请求，原图留给放大查看。
String readingImageUrl(String source,
    {required double width, required double pixelRatio}) {
  final Uri? uri = Uri.tryParse(source);
  if (uri == null ||
      uri.host != 'pc.toly1994.com' ||
      !<String>['http', 'https'].contains(uri.scheme) ||
      !uri.path.startsWith('/oss/o/') ||
      !width.isFinite ||
      width <= 0 ||
      !pixelRatio.isFinite ||
      pixelRatio <= 0) {
    return source;
  }
  final String? format = const <String, String>{
    'jpg': 'jpeg',
    'jpeg': 'jpeg',
    'png': 'png',
    'webp': 'webp',
  }[uri.path.split('.').last.toLowerCase()];
  // GIF、SVG 及未知编码使用原资源，避免静态缩放破坏动画或兼容性。
  if (format == null) return source;
  final double previewRatio = math.max(1.0, pixelRatio - 1);
  int pixels(double size) =>
      ((size * previewRatio).clamp(1, 2048) / 64).ceil() * 64;
  final Map<String, String> parameters = <String, String>{
    ...uri.queryParameters,
    'w': '${pixels(width)}',
    'fit': 'contain',
    'format': uri.queryParameters['format'] ?? format,
  }..remove('h');
  return uri.replace(queryParameters: parameters).toString();
}
