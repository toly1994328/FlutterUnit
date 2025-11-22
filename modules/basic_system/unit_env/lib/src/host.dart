import 'package:fx_dio/fx_dio.dart';

class UnitEnv {
  static String? userName;
}

class Unit3Host extends Host {
  const Unit3Host();

  @override
  Map<HostEnv, String> get value => {
        HostEnv.release: 'toly1994.com',
        HostEnv.dev: '192.168.1.61',
      };

  @override
  HostConfig get config => const HostConfig(
        scheme: 'http',
        port: 3000,
        apiNest: '/api/v1',
      );

  @override
  HostEnv get env => HostEnv.release;
}

mixin ScienceHostMixin {
  Host get host => FxDio()<Unit3Host>();
}
