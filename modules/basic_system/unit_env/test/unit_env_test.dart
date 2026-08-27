import 'package:flutter_test/flutter_test.dart';
import 'package:unit_env/unit_env.dart';

void main() {
  test('补全带前导斜杠的服务端资源路径', () {
    final Uri uri = FlutterUnitHost.resolveResource(
      '/uploads/original/2026/08/cover.jpeg',
    );

    expect(uri.path, '/uploads/original/2026/08/cover.jpeg');
    expect(uri.host, isNotEmpty);
    expect(uri.port, 9602);
  });

  test('补全不带前导斜杠的服务端资源路径', () {
    final Uri uri = FlutterUnitHost.resolveResource(
      'uploads/original/2026/08/cover.jpeg',
    );

    expect(uri.path, '/uploads/original/2026/08/cover.jpeg');
  });

  test('完整外部资源地址保持不变', () {
    const String location = 'https://cdn.example.com/cover.webp?w=320';

    expect(FlutterUnitHost.resolveResource(location).toString(), location);
  });

  test('本机原图追加动态图片参数', () {
    final Uri uri = FlutterUnitHost.resolveImageResource(
      '/uploads/original/2026/08/cover.jpeg',
      width: 640,
    );

    expect(uri.queryParameters['w'], '640');
    expect(uri.queryParameters['q'], '80');
    expect(uri.queryParameters['format'], 'webp');
  });
}
