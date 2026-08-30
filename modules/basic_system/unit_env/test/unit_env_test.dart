import 'package:flutter_test/flutter_test.dart';
import 'package:unit_env/unit_env.dart';

void main() {
  test('补全带前导斜杠的服务端资源路径', _resolvesLeadingSlashPath);
  test('补全不带前导斜杠的服务端资源路径', _resolvesPathWithoutSlash);
  test('完整外部资源地址保持不变', _keepsExternalResource);
  test('当前服务上传资源补全 API 前缀', _repairsCurrentServerUpload);
  test('已有 API 前缀的上传资源保持不变', _keepsPrefixedServerUpload);
  test('本机原图追加动态图片参数', _appendsImageParameters);
}

void _resolvesLeadingSlashPath() {
  final Uri uri = FlutterUnitHost.resolveResource(
    '/uploads/original/2026/08/cover.jpeg',
  );

  expect(uri.path, '$_apiNest/uploads/original/2026/08/cover.jpeg');
  expect(uri.host, isNotEmpty);
  if (_serverPort != 0) {
    expect(uri.port, _serverPort);
  }
}

void _resolvesPathWithoutSlash() {
  final Uri uri = FlutterUnitHost.resolveResource(
    'uploads/original/2026/08/cover.jpeg',
  );

  expect(uri.path, '$_apiNest/uploads/original/2026/08/cover.jpeg');
}

void _keepsExternalResource() {
  const String location = 'https://cdn.example.com/cover.webp?w=320';

  expect(FlutterUnitHost.resolveResource(location).toString(), location);
}

void _repairsCurrentServerUpload() {
  const String location =
      'https://fx.toly1994.com/uploads/original/2026/08/avatar.png';

  final Uri uri = FlutterUnitHost.resolveResource(location);

  expect(uri.host, 'fx.toly1994.com');
  expect(uri.path, '$_apiNest/uploads/original/2026/08/avatar.png');
}

void _keepsPrefixedServerUpload() {
  const String location =
      'https://fx.toly1994.com/unit/uploads/original/2026/08/avatar.png';

  expect(FlutterUnitHost.resolveResource(location).toString(), location);
}

void _appendsImageParameters() {
  final Uri uri = FlutterUnitHost.resolveImageResource(
    '/uploads/original/2026/08/cover.jpeg',
    width: 640,
  );

  expect(uri.path, '$_apiNest/uploads/original/2026/08/cover.jpeg');
  expect(uri.queryParameters['w'], '640');
  expect(uri.queryParameters['q'], '80');
  expect(uri.queryParameters['format'], 'webp');
}

const String _apiNest = String.fromEnvironment('API_NEST');
const int _serverPort = int.fromEnvironment('SERVER_PORT');
