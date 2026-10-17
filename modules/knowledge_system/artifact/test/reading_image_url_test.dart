import 'package:artifact/src/articles/view/article/reading/reading_image_url.dart';
import 'package:artifact/src/articles/view/article/reading/reading_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'support/reading_image_cache.dart';

void main() {
  setUp(configureReadingImageCache);
  tearDown(resetReadingImageCache);
  test('正文像素比减一后分档，保留格式和原有参数', testPreview);
  test('正文请求像素比最低一倍', testMinimumRatio);
  test('外站、动图和无效尺寸保持原链接', testBypass);
  testWidgets('阅读图片预览使用尺寸参数，点击放大使用原图', testImagePreview);
}

Future<void> testImagePreview(WidgetTester tester) async {
  const String source = 'https://pc.toly1994.com/oss/o/photo.png';
  tester.view.devicePixelRatio = 2;
  tester.view.physicalSize = const Size(800, 1600);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
          body: SingleChildScrollView(child: ReadingImage(url: source)))));
  final Image preview = tester.widget<Image>(find.byType(Image));
  final Uri previewUrl =
      Uri.parse((preview.image as CachedNetworkImageProvider).url);
  expect(previewUrl.queryParameters['w'], '448');
  expect(previewUrl.queryParameters['fit'], 'contain');
  await tester.tap(find.byType(InkWell));
  await tester.pump();
  final Finder zoom = find.descendant(
      of: find.byType(InteractiveViewer), matching: find.byType(Image));
  final Image original = tester.widget<Image>(zoom);
  expect((original.image as CachedNetworkImageProvider).url, source);
  expect(tester.takeException(), isNull);
  await tester.pumpWidget(const SizedBox());
}

void testPreview() {
  const String source = 'https://pc.toly1994.com/oss/o/photo.png?v=2&h=1088';
  final Uri preview =
      Uri.parse(readingImageUrl(source, width: 380, pixelRatio: 2.75));
  expect(preview.queryParameters, <String, String>{
    'v': '2',
    'w': '704',
    'fit': 'contain',
    'format': 'png',
  });
  final Uri large =
      Uri.parse(readingImageUrl(source, width: 5000, pixelRatio: 3));
  expect(large.queryParameters['w'], '2048');
  expect(large.queryParameters.containsKey('h'), isFalse);
  final Uri jpeg = Uri.parse(readingImageUrl(source.replaceAll('.png', '.jpg'),
      width: 400, pixelRatio: 1));
  expect(jpeg.queryParameters['format'], 'jpeg');
}

void testMinimumRatio() {
  const String source = 'https://pc.toly1994.com/oss/o/photo.png';
  for (final double ratio in <double>[0.75, 1, 1.5, 2]) {
    final Uri preview =
        Uri.parse(readingImageUrl(source, width: 380, pixelRatio: ratio));
    expect(preview.queryParameters['w'], '384');
    expect(preview.queryParameters.containsKey('h'), isFalse);
  }
}

void testBypass() {
  for (final String source in <String>[
    'https://other.com/oss/o/photo.png',
    'https://pc.toly1994.com.evil.com/oss/o/photo.png',
    'https://pc.toly1994.com/oss/o/animation.gif',
    'https://pc.toly1994.com/oss/o/image.avif',
    'https://pc.toly1994.com/image.png',
    'http://localhost:9602/articles/one/images/photo.png',
  ]) {
    expect(readingImageUrl(source, width: 400, pixelRatio: 3), source);
  }
  const String source = 'https://pc.toly1994.com/oss/o/photo.webp';
  expect(
      readingImageUrl(source, width: double.infinity, pixelRatio: 2), source);
  expect(readingImageUrl(source, width: 400, pixelRatio: 0), source);
}
