import 'package:fx_dio/fx_dio.dart';

class UnitEnv {
  /// 当前请求使用的访客名称。
  static String? userName;
}

/// FlutterUnit 所有业务接口使用的唯一服务端 Host。
class FlutterUnitHost extends Host {
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
    defaultValue: 9602,
  );

  /// 当前客户端唯一使用的服务地址。
  static Uri get serverUri => Uri(scheme: _scheme, host: _host, port: _port);

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
        port: _port,
      );

  @override
  HostEnv get env => HostEnv.dev;
}

/// 为业务 Repository 提供统一 Host。
mixin FlutterUnitHostMixin {
  /// 当前已注册的 FlutterUnit Host。
  Host get host => FxDio()<FlutterUnitHost>();
}
