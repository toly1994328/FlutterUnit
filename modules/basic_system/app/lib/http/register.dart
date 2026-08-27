import 'dart:async';

import 'package:app/app.dart';
import 'package:fx_dio/fx_dio.dart';
import 'package:unit_env/unit_env.dart';
import 'http.dart';

/// 在任何用户会话或业务 Provider 构造前注册唯一服务 Host。
void registerFlutterUnitHost() {
  FxDio().register(
    const FlutterUnitHost(),
    options: HostOptions(
      repInterceptor: FlutterUnitResponseInterceptor(),
    ),
  );
}

/// 启动配置就绪后补充本地化请求头和认证拦截器。
void configureFlutterUnitHttp(bool isZh) {
  UnitEnv.userName = '游客:${kAppMeta.uuid.substring(0, 6)}';
  FxDio().auth<FlutterUnitHost>(FlutterUnitApiAuth(isZh));
}

class FlutterUnitApiAuth extends ApiAuth {
  /// 当前界面是否使用中文。
  final bool isZh;

  FlutterUnitApiAuth(this.isZh);

  @override
  FutureOr<Map<String, dynamic>> get buildHeaders => {
        ...kAppMeta.toHeaderJson(),
        'locale': isZh ? 'zh-CN' : 'en',
        if (UnitEnv.accessToken case final String token)
          'Authorization': 'Bearer $token',
      };
}
