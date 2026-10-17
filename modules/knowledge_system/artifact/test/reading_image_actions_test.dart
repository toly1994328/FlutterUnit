import 'package:artifact/src/articles/view/article/reading/reading_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'support/reading_image_cache.dart';

void main() {
  setUp(configureImageClient);
  tearDown(resetImageClient);
  testWidgets('长按复制实际渲染地址及尺寸参数，关闭菜单且不打开大图', testCopy);
  testWidgets('变换失败回退原图，复制当前显示的原图地址', testFallbackCopy);
  testWidgets('长按菜单可打开原图并缩放', testZoom);
}

void configureImageClient() {
  configureReadingImageCache();
}

void resetImageClient() {
  resetReadingImageCache();
}

const String original = 'https://pc.toly1994.com/oss/o/photo.png?v=2';

Future<void> mount(WidgetTester tester) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(400, 800);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
          body: SingleChildScrollView(child: ReadingImage(url: original)))));
  await tester.longPress(find.byType(InkWell));
  await tester.pump(const Duration(milliseconds: 350));
}

Future<void> testCopy(WidgetTester tester) async {
  await verifyCopy(tester);
}

Future<void> testFallbackCopy(WidgetTester tester) async {
  configureReadingImageCache(failVariants: true);
  await verifyCopy(tester, fallback: true);
}

Future<void> verifyCopy(WidgetTester tester, {bool fallback = false}) async {
  String? copied;
  Future<Object?> clipboard(MethodCall call) async {
    if (call.method == 'Clipboard.setData') {
      copied = (call.arguments as Map<dynamic, dynamic>)['text'] as String;
    }
    return null;
  }

  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(SystemChannels.platform, clipboard);
  addTearDown(() => TestDefaultBinaryMessengerBinding
      .instance.defaultBinaryMessenger
      .setMockMethodCallHandler(SystemChannels.platform, null));
  await mount(tester);
  final Image rendered = tester.widget<Image>(find.byType(Image));
  final String renderedUrl = (rendered.image as CachedNetworkImageProvider).url;
  if (fallback) {
    expect(renderedUrl, original);
  } else {
    expect(Uri.parse(renderedUrl).queryParameters['w'], '448');
  }
  expect(Uri.parse(renderedUrl).queryParameters.containsKey('h'), isFalse);
  expect(Uri.parse(renderedUrl).queryParameters['v'], '2');
  expect(find.text('保存图片'), findsOneWidget);
  expect(find.text('复制链接'), findsOneWidget);
  expect(find.text('查看大图'), findsOneWidget);
  expect(tester.getSize(find.byType(BottomSheet)).width, 400);
  await tester.tap(find.text('复制链接'));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 350));
  expect(copied, renderedUrl);
  expect(find.byType(BottomSheet), findsNothing);
  expect(find.byType(InteractiveViewer), findsNothing);
  expect(find.text('图片链接已复制'), findsOneWidget);
  expect(tester.takeException(), isNull);
  await tester.pumpWidget(const SizedBox());
  resetImageClient();
}

Future<void> testZoom(WidgetTester tester) async {
  await mount(tester);
  await tester.tap(find.text('查看大图'));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 350));
  final Finder image = find.descendant(
      of: find.byType(InteractiveViewer), matching: find.byType(Image));
  expect((tester.widget<Image>(image).image as CachedNetworkImageProvider).url,
      original);
  expect(tester.takeException(), isNull);
  await tester.pumpWidget(const SizedBox());
  resetImageClient();
}
