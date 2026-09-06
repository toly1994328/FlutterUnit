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
  setFlutterUnitLocale(isZh);
  FxDio().auth<FlutterUnitHost>(FlutterUnitApiAuth());
}

class FlutterUnitApiAuth extends ApiAuth {
  @override
  FutureOr<Map<String, dynamic>> get buildHeaders => {
        ...kAppMeta.toHeaderJson(),
        'Accept-Language': UnitEnv.locale,
        if (UnitEnv.accessToken case final String token)
          'Authorization': 'Bearer $token',
      };
}

/// 更新后续业务请求使用的语言，不重复安装认证拦截器。
void setFlutterUnitLocale(bool isZh) {
  UnitEnv.locale = isZh ? 'zh-CN' : 'en';
}
