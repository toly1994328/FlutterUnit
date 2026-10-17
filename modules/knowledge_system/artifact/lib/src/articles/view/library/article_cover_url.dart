/// 文章封面按实际物理尺寸分档请求，文档资源和 CraftOSS 保留原图编码。
String articleCoverUrl(String source,
    {required double width,
    required double height,
    required double pixelRatio}) {
  final Uri? uri = Uri.tryParse(source);
  if (uri == null ||
      !<String>['http', 'https'].contains(uri.scheme) ||
      !width.isFinite ||
      width <= 0 ||
      !height.isFinite ||
      height <= 0 ||
      !pixelRatio.isFinite ||
      pixelRatio <= 0) {
    return source;
  }
  final bool document = RegExp(
          r'(^|/)articles/[^/]+/thumbnail\.(png|jpe?g|webp)$',
          caseSensitive: false)
      .hasMatch(uri.path);
  final bool oss = RegExp(r'(^|/)o/[^/]+$').hasMatch(uri.path);
  final String? format = const <String, String>{
    'jpg': 'jpeg',
    'jpeg': 'jpeg',
    'png': 'png',
    'webp': 'webp',
  }[uri.path.split('.').last.toLowerCase()];
  if ((!document && !oss) || format == null) return source;
  int pixels(double size) =>
      (((size * pixelRatio).clamp(1, 2048) / 64).ceil() * 64);
  return uri.replace(queryParameters: <String, String>{
    ...uri.queryParameters,
    'w': '${pixels(width)}',
    'h': '${pixels(height)}',
    if (oss) 'fit': 'cover',
    if (oss) 'format': uri.queryParameters['format'] ?? format,
  }).toString();
}
