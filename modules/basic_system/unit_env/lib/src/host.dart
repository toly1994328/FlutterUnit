import 'package:fx_dio/fx_dio.dart';

class ScienceHost extends Host {
  const ScienceHost();

  @override
  Map<HostEnv, String> get value => {
        HostEnv.release: 'toly1994.com',
        // HostEnv.dev: '192.168.1.61',
        HostEnv.dev: '192.168.0.40',
        // HostEnv.dev: '172.29.240.1',
      };

  @override
  HostConfig get config => const HostConfig(
        scheme: 'http',
        port: 3000,
        apiNest: '/api/v1',
      );

  @override
  HostEnv get env => HostEnv.dev;
}

mixin ScienceHostMixin {
  Host get host => FxDio()<ScienceHost>();
}
