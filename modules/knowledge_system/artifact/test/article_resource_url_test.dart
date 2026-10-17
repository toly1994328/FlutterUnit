import 'package:artifact/src/articles/env/artifact_env.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fx_dio/fx_dio.dart';

void main() {
  setUp(attachTestEnvironment);
  test('旧本机文档封面和正文资源改用当前服务', resolvesLocalDocuments);
  test('相对资源补全环境地址并保留查询参数', resolvesRelativeResource);
  test('外部 OSS 和其他本机服务不重写', keepsOtherServices);
}

void attachTestEnvironment() => ArtifactEnv().attachBridge(TestArticleBridge());

void resolvesLocalDocuments() {
  for (final String origin in <String>[
    'http://localhost:9602',
    'http://127.0.0.1:9602',
    'http://[::1]:9602',
  ]) {
    expect(
        ArtifactEnv()
            .resolveResource('$origin/articles/one/thumbnail.webp?w=192&h=192'),
        'https://test.example.com/unit/articles/one/thumbnail.webp?w=192&h=192');
    expect(ArtifactEnv().resolveResource('$origin/articles/one/images/a.png'),
        'https://test.example.com/unit/articles/one/images/a.png');
    expect(ArtifactEnv().resolveResource('$origin/articles/one/'),
        'https://test.example.com/unit/articles/one/');
  }
}

void resolvesRelativeResource() {
  expect(ArtifactEnv().resolveResource('/articles/one/thumbnail.webp?v=2'),
      'https://test.example.com/unit/articles/one/thumbnail.webp?v=2');
}

void keepsOtherServices() {
  for (final String location in <String>[
    'https://pc.toly1994.com/oss/o/cover.jpg?w=640&h=360',
    'https://cdn.example.com/articles/one/thumbnail.webp',
    'http://localhost:9602/other/image.png',
  ]) {
    expect(ArtifactEnv().resolveResource(location), location);
  }
}

class TestArticleBridge with ArtifactModuleBridge {
  @override
  RequestHost<HostEnv> get host => throw UnimplementedError();

  @override
  String resolveResource(String location) {
    final Uri uri = Uri.parse(location);
    if (uri.hasScheme) return location;
    return Uri.parse('https://test.example.com/unit/')
        .resolve(location.startsWith('/') ? location.substring(1) : location)
        .toString();
  }
}
