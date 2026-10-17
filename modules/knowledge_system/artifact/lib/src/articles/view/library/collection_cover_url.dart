/// 按卡片宽度和屏幕倍率请求 CraftOSS 封面，保留原图编码和既有查询参数。
String collectionCoverUrl(String source,
    {required double logicalWidth, required double pixelRatio}) {
  final Uri? uri = Uri.tryParse(source);
  if (uri == null ||
      !<String>['http', 'https'].contains(uri.scheme) ||
      !RegExp(r'(^|/)o/[^/]+$').hasMatch(uri.path) ||
      !logicalWidth.isFinite ||
      logicalWidth <= 0 ||
      !pixelRatio.isFinite ||
      pixelRatio <= 0) {
    return source;
  }
  final String extension = uri.path.split('.').last.toLowerCase();
  final String? format = const <String, String>{
    'jpg': 'jpeg',
    'jpeg': 'jpeg',
    'png': 'png',
    'webp': 'webp',
  }[extension];
  // 未知编码不请求变换，避免后端默认 WebP 导致意外格式转换。
  if (format == null) return source;
  final int width =
      ((logicalWidth * pixelRatio / 64).ceil() * 64).clamp(64, 2048);
  return uri.replace(queryParameters: <String, String>{
    ...uri.queryParameters,
    'w': '$width',
    'h': '${width * 9 ~/ 16}',
    'format': uri.queryParameters['format'] ?? format,
  }).toString();
}
