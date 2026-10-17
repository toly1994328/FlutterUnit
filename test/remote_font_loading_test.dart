import 'dart:io';
import 'dart:typed_data';

import 'package:app/app/typography/remote_font_package.dart';
import 'package:app/app/typography/remote_font_store.dart';
import 'package:app/app/typography/windows_font_controller.dart';
import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FontFixture fixture;

  setUp(() async {
    fixture = await FontFixture.create();
  });
  tearDown(() async {
    await fixture.close();
  });

  test('下载并解压指定文件，缓存可离线复用', () async {
    final Directory directory = await fixture.store.prepare();
    expect(await File('${directory.path}/Regular.ttf').readAsBytes(),
        fixture.fontBytes);
    expect(fixture.requests, 1);
    await fixture.server.close(force: true);
    expect((await fixture.store.prepare()).path, directory.path);
    expect(fixture.requests, 1);
    expect(await File('${directory.path}/package.zip.part').exists(), isFalse);
  });

  test('同样长度的损坏缓存会重新下载', () async {
    final Directory directory = await fixture.store.prepare();
    await File('${directory.path}/Regular.ttf')
        .writeAsBytes(Uint8List(fixture.fontBytes.length));
    await fixture.store.prepare();
    expect(fixture.requests, 2);
    expect(await File('${directory.path}/Regular.ttf').readAsBytes(),
        fixture.fontBytes);
  });

  test('不接受被篡改的 ZIP，不加载未校验的字体', () async {
    fixture.responseBytes = Uint8List(fixture.zipBytes.length);
    await expectLater(fixture.store.prepare(), throwsFormatException);
    expect(
        await File('${fixture.directory.path}/Regular.ttf').exists(), isFalse);
    expect(await File('${fixture.directory.path}/package.zip.part').exists(),
        isFalse);
  });

  test('同一时刻的调用合并为一次下载和一次引擎注册', () async {
    int registrations = 0;
    Future<void> register(Directory directory) async {
      registrations++;
    }

    final WindowsFontController controller = WindowsFontController(
        store: fixture.store, registrar: register, supported: true);
    await Future.wait(<Future<void>>[
      controller.ensureLoaded(),
      controller.ensureLoaded(),
    ]);
    expect(controller.ready, isTrue);
    expect(controller.loading, isFalse);
    expect(controller.error, isNull);
    expect(registrations, 1);
    expect(fixture.requests, 1);
    await controller.ensureLoaded();
    expect(registrations, 1);
    controller.dispose();
  });

  test('失败保持系统字体，重试成功后自动启用在线字体', () async {
    fixture.failRequests = true;
    Future<void> register(Directory directory) async {}
    final WindowsFontController controller = WindowsFontController(
        store: fixture.store, registrar: register, supported: true);
    expect(
        controller.resolveFamily(wenKaiLitePackage.family), 'Microsoft YaHei');
    await controller.ensureLoaded();
    expect(controller.ready, isFalse);
    expect(controller.error, isNotNull);
    fixture.failRequests = false;
    await controller.ensureLoaded();
    expect(controller.resolveFamily(wenKaiLitePackage.family),
        wenKaiLitePackage.family);
    expect(controller.error, isNull);
    controller.dispose();
  });

  test('其他平台不下载字体，也不覆盖用户选择的其他字体', () async {
    final WindowsFontController controller =
        WindowsFontController(store: fixture.store, supported: false);
    await controller.ensureLoaded();
    expect(fixture.requests, 0);
    expect(controller.resolveFamily('ComicNeue'), 'ComicNeue');
    expect(controller.resolveFamily('local'), '');
    controller.dispose();
  });
}

/// 通过本地 HTTP 服务覆盖真实 ZIP 下载和磁盘缓存行为。
class FontFixture {
  FontFixture(this.directory, this.server, this.fontBytes, this.zipBytes) {
    responseBytes = zipBytes;
    final RemoteFontPackage package = RemoteFontPackage(
        family: 'Test Font',
        version: '1',
        url: 'http://${server.address.address}:${server.port}/font.zip',
        size: zipBytes.length,
        sha256: sha256.convert(zipBytes).toString(),
        files: <RemoteFontFile>[
          RemoteFontFile('Regular.ttf', fontBytes.length,
              sha256.convert(fontBytes).toString()),
        ]);
    store =
        RemoteFontStore(package: package, directoryProvider: cacheDirectory);
    server.listen(serve);
  }

  /// 当前测试独立的缓存目录。
  final Directory directory;

  /// 提供可控制响应的本地 HTTP 服务。
  final HttpServer server;

  /// 模拟字体文件的原始数据。
  final Uint8List fontBytes;

  /// 可供校验的 ZIP 原始数据。
  final Uint8List zipBytes;

  /// 实际响应内容，可修改以模拟传输损坏。
  late Uint8List responseBytes;

  /// 待测试的真实下载和缓存实现。
  late RemoteFontStore store;

  /// 服务接收到的请求数。
  int requests = 0;

  /// 是否暂时模拟服务不可用。
  bool failRequests = false;

  static Future<FontFixture> create() async {
    final Directory directory =
        await Directory.systemTemp.createTemp('font-test-');
    final HttpServer server =
        await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final Uint8List font = Uint8List.fromList(<int>[0, 1, 0, 0, 7, 8, 9]);
    final Archive archive = Archive()
      ..addFile(ArchiveFile('Regular.ttf', font.length, font))
      // 清单外的路径不会被解压到磁盘。
      ..addFile(ArchiveFile('../escaped.txt', 3, <int>[1, 2, 3]));
    final Uint8List zip = Uint8List.fromList(ZipEncoder().encode(archive));
    return FontFixture(directory, server, font, zip);
  }

  Future<Directory> cacheDirectory() async => directory;

  /// 模拟成功、篡改和断网后的 HTTP 响应。
  Future<void> serve(HttpRequest request) async {
    requests++;
    request.response.statusCode = failRequests ? 503 : 200;
    request.response.add(responseBytes);
    await request.response.close();
  }

  Future<void> close() async {
    await server.close(force: true);
    await directory.delete(recursive: true);
  }
}
