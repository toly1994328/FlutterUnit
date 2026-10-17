import 'package:artifact/src/articles/view/library/collection_cover_url.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('按物理像素请求 16:9 缩略图，JPEG 不转 WebP 且不添加质量参数', testJpeg);
  test('其他原图编码及查询参数保留，不修改非 CraftOSS 图片地址', testOtherSources);
}

void testJpeg() {
  final Uri result = Uri.parse(collectionCoverUrl(
      'https://example.com/oss/o/obj_cover.jpg?v=1',
      logicalWidth: 252,
      pixelRatio: 1.5));
  expect(result.path, '/oss/o/obj_cover.jpg');
  expect(result.queryParameters, <String, String>{
    'v': '1',
    'w': '384',
    'h': '216',
    'format': 'jpeg',
  });
  expect(result.queryParameters.containsKey('q'), isFalse);
}

void testOtherSources() {
  final Uri png = Uri.parse(collectionCoverUrl(
      'https://example.com/oss/o/obj_cover.png?v=2',
      logicalWidth: 260,
      pixelRatio: 2));
  expect(png.queryParameters['format'], 'png');
  expect(png.queryParameters['v'], '2');
  expect(int.parse(png.queryParameters['w']!), greaterThanOrEqualTo(520));
  for (final String source in <String>[
    'http://localhost:9602/articles/one/thumbnail.webp',
    'https://example.com/oss/o/obj_animation.gif',
  ]) {
    expect(
        collectionCoverUrl(source, logicalWidth: 260, pixelRatio: 1.5), source);
  }
}
