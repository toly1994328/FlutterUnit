import 'dart:convert';
import 'package:artifact/src/articles/view/article/reading/reading_image_save.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// 模拟原图下载，记录请求，校验保存过程没有请求缩略图或重新编码。
class ImageAdapter implements HttpClientAdapter {
  /// 下载后应原样交给系统相册的 GIF 数据。
  final Uint8List bytes =
      base64Decode('R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7');

  /// 最近一次下载的地址。
  Uri? requested;

  /// 模拟服务错误时返回的状态码。
  final int status;
  ImageAdapter({this.status = 200});
  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<Uint8List>? requestStream, Future<void>? cancelFuture) async {
    requested = options.uri;
    return ResponseBody.fromBytes(bytes, status);
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(setPlatform);
  tearDown(clearPlatform);
  test('GIF 原图按原始字节和 MIME 写入相册，成功后才反馈保存完成', testSave);
  test('下载失败不写相册，系统写入失败向调用方报告错误', testFailures);
}

void setPlatform() =>
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
void clearPlatform() {
  debugDefaultTargetPlatformOverride = null;
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(readingImageChannel, null);
}

Future<void> testSave() async {
  final ImageAdapter adapter = ImageAdapter();
  final Dio client = Dio()..httpClientAdapter = adapter;
  MethodCall? saved;
  Future<Object?> gallery(MethodCall call) async {
    saved = call;
    return 'content://media/external/images/media/1';
  }

  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(readingImageChannel, gallery);
  const String original = 'https://pc.toly1994.com/oss/o/animation.gif?v=2';
  expect(
      await saveReadingImage(original, client: client), '已保存到相册 FlutterUnit');
  expect(adapter.requested.toString(), original);
  expect(saved!.method, 'saveToGallery');
  final Map<dynamic, dynamic> data = saved!.arguments as Map<dynamic, dynamic>;
  expect(data['bytes'], orderedEquals(adapter.bytes));
  expect(data['mime'], 'image/gif');
  expect(data['name'], endsWith('.gif'));
  client.close();
}

Future<void> testFailures() async {
  int writes = 0;
  Future<Object?> gallery(MethodCall call) async {
    writes++;
    throw PlatformException(code: 'save_failed');
  }

  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(readingImageChannel, gallery);
  final Dio failed = Dio()..httpClientAdapter = ImageAdapter(status: 500);
  await expectLater(
      saveReadingImage('https://example.com/photo.gif', client: failed),
      throwsA(isA<DioException>()));
  expect(writes, 0);
  final Dio success = Dio()..httpClientAdapter = ImageAdapter();
  await expectLater(
      saveReadingImage('https://example.com/photo.gif', client: success),
      throwsA(isA<PlatformException>()));
  expect(writes, 1);
  failed.close();
  success.close();
}
