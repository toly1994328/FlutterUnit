import 'package:fx_dio/fx_dio.dart';

/// 由应用组装层注入 HTTP 主机，文章模块共享客户端当前环境。
class ArtifactEnv {
  ArtifactEnv._();

  /// 模块环境唯一实例。
  static final ArtifactEnv _instance = ArtifactEnv._();
  factory ArtifactEnv() => _instance;

  /// 应用提供的请求桥接。
  ArtifactModuleBridge? _bridge;

  void attachBridge(ArtifactModuleBridge bridge) => _bridge = bridge;

  RequestHost<HostEnv> get host => _bridge!.host;

  /// 本站文档中的旧本机地址改用当前环境，外部图片保留原地址。
  String resolveResource(String location) {
    final ArtifactModuleBridge? bridge = _bridge;
    if (bridge == null) return location;
    final Uri? resource = Uri.tryParse(location);
    final bool localDocument = resource != null &&
        <String>['http', 'https'].contains(resource.scheme) &&
        <String>['localhost', '127.0.0.1', '::1'].contains(resource.host) &&
        resource.userInfo.isEmpty &&
        resource.path.startsWith('/articles/');
    if (!localDocument) return bridge.resolveResource(location);
    final Uri relative = Uri(
      path: resource.path,
      query: resource.hasQuery ? resource.query : null,
      fragment: resource.hasFragment ? resource.fragment : null,
    );
    return bridge.resolveResource(relative.toString());
  }
}

mixin ArtifactModuleBridge {
  RequestHost<HostEnv> get host;

  /// 使用应用当前配置的服务地址补全本站资源。
  String resolveResource(String location);
}
