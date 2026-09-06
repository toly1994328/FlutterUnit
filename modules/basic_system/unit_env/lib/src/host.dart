import 'package:fx_dio/fx_dio.dart';

/// FlutterUnit 的发行渠道。
enum UnitDistribution {
  /// 国内渠道，允许应用内检测并安装更新。
  china,

  /// Google Play 渠道，更新完全交由应用商店管理。
  google,
}

class UnitEnv {
  /// 构建时通过 `APP_FLAVOR` 注入的发行渠道名称。
  static const String _distributionName = String.fromEnvironment(
    'APP_FLAVOR',
    defaultValue: 'china',
  );

  /// 当前请求使用的访客名称。
  static String? userName;

  /// 当前登录会话使用的 Bearer Token。
  static String? accessToken;

  /// 当前业务请求使用的标准语言标签。
  static String locale = 'zh-CN';

  /// 当前应用的发行渠道。
  static const UnitDistribution distribution = _distributionName == 'google'
      ? UnitDistribution.google
      : UnitDistribution.china;

  /// 是否允许使用应用内更新能力。
  static const bool supportsInAppUpdate =
      distribution == UnitDistribution.china;
}

/// FlutterUnit 所有业务接口使用的唯一服务端 Host。
class FlutterUnitHost extends RequestHost<HostEnv> {
  /// 服务协议，由客户端环境文件注入。
  static const String _scheme = String.fromEnvironment(
    'SERVER_SCHEME',
    defaultValue: 'http',
  );

  /// 服务主机，由客户端环境文件注入。
  static const String _host = String.fromEnvironment(
    'SERVER_HOST',
    defaultValue: '127.0.0.1',
  );

  /// 服务端口，由客户端环境文件注入。
  static const int _port = int.fromEnvironment(
    'SERVER_PORT',
    defaultValue: 0,
  );

  static const String _apiNest = String.fromEnvironment(
    'API_NEST',
    defaultValue: '',
  );

  /// 当前客户端唯一使用的服务地址。
  static Uri get serverUri => Uri(
        scheme: _scheme,
        host: _host,
        port: _port == 0 ? null : _port,
      );

  /// 将服务端相对资源路径补全为可访问 URI，完整网络地址保持不变。
  static Uri resolveResource(String location) {
    final Uri resource = Uri.parse(location);
    if (resource.hasScheme) {
      return _resolveCurrentServerUpload(resource);
    }
    final String path =
        resource.path.startsWith('/') ? resource.path : '/${resource.path}';
    return serverUri.replace(
      path: _apiNest + path,
      queryParameters:
          resource.queryParameters.isEmpty ? null : resource.queryParameters,
      fragment: resource.fragment.isEmpty ? null : resource.fragment,
    );
  }

  /// 为本机原图追加动态图片参数，外部资源仅完成地址解析。
  static Uri resolveImageResource(
    String location, {
    int? width,
    int? height,
    int quality = 80,
    String format = 'webp',
  }) {
    final Uri source = Uri.parse(location);
    final Uri resource = resolveResource(location);
    if (!_isOriginalUploadPath(source.path)) {
      return resource;
    }
    final Map<String, String> query = Map<String, String>.of(
      resource.queryParameters,
    );
    if (width != null) {
      query['w'] = '$width';
    }
    if (height != null) {
      query['h'] = '$height';
    }
    query['q'] = '$quality';
    query['format'] = format;
    return resource.replace(queryParameters: query);
  }

  static bool _isOriginalUploadPath(String path) {
    final String normalizedPath = path.startsWith('/') ? path : '/$path';
    final String resourcePath =
        _apiNest.isNotEmpty && normalizedPath.startsWith('$_apiNest/')
            ? normalizedPath.substring(_apiNest.length)
            : normalizedPath;
    return resourcePath.startsWith('/uploads/original/');
  }

  static Uri _resolveCurrentServerUpload(Uri resource) {
    final bool isCurrentServer = resource.host == _host;
    final bool hasApiNest = _apiNest.isNotEmpty &&
        (resource.path == _apiNest || resource.path.startsWith('$_apiNest/'));
    if (!isCurrentServer ||
        hasApiNest ||
        !_isOriginalUploadPath(resource.path)) {
      return resource;
    }
    return serverUri.replace(
      path: '$_apiNest${resource.path}',
      query: resource.hasQuery ? resource.query : null,
      fragment: resource.hasFragment ? resource.fragment : null,
    );
  }

  /// 兼容仍使用字符串地址的旧网络入口。
  static String get serverUrl => serverUri.toString();

  const FlutterUnitHost();

  @override
  Map<HostEnv, String> get value => {
        HostEnv.release: _host,
        HostEnv.dev: _host,
      };

  @override
  HostConfig get config => const HostConfig(
        scheme: _scheme,
        port: _port == 0 ? null : _port,
        apiNest: _apiNest,
      );

  @override
  HostEnv get env => HostEnv.dev;
}

/// 为业务 Repository 提供统一 Host。
mixin FlutterUnitHostMixin {
  /// 当前已注册的 FlutterUnit Host。
  RequestHost<HostEnv> get host => FxDio()<FlutterUnitHost>();
}
