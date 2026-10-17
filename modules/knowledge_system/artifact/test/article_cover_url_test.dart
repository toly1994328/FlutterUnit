import 'package:artifact/src/articles/view/library/article_cover_url.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('文档封面按物理像素分档，保留原格式和已有参数', testDocument);
  test('CraftOSS 封面匹配方形裁切，动图和外站链接保持原样', testSources);
}

void testDocument() {
  final Uri url = Uri.parse(articleCoverUrl(
      'http://localhost:9602/articles/one/thumbnail.webp?v=2',
      width: 112,
      height: 112,
      pixelRatio: 1.5));
  expect(
      url.queryParameters, <String, String>{'v': '2', 'w': '192', 'h': '192'});
  expect(url.path, '/articles/one/thumbnail.webp');
  final Uri large = Uri.parse(articleCoverUrl(url.toString(),
      width: 5000, height: 5000, pixelRatio: 2));
  expect(large.queryParameters['w'], '2048');
  expect(
      articleCoverUrl(url.toString(),
          width: double.nan, height: 112, pixelRatio: 1),
      url.toString());
}

void testSources() {
  final Uri oss = Uri.parse(articleCoverUrl(
      'https://example.com/oss/o/cover.jpg',
      width: 112,
      height: 112,
      pixelRatio: 1.5));
  expect(oss.queryParameters, <String, String>{
    'w': '192',
    'h': '192',
    'fit': 'cover',
    'format': 'jpeg'
  });
  for (final String source in <String>[
    'https://example.com/articles/one/thumbnail.gif',
    'https://example.com/oss/o/animation.gif',
    'https://example.com/cover.webp',
    'http://localhost:9602/articles/one/images/photo.png',
  ]) {
    expect(articleCoverUrl(source, width: 112, height: 112, pixelRatio: 1.5),
        source);
  }
}
