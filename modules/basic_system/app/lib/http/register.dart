import 'dart:async';

import 'package:app/app.dart';
import 'package:fx_dio/fx_dio.dart';
import 'package:unit_env/unit_env.dart';
import 'http.dart';

void registerHttpClient(bool isZh) {
  FxDio()
      .register(const ScienceHost(), repInterceptor: ScienceRepInterceptor());
  FxDio().register(const Unit3Host());
  FxDio().register(const UnitHost());
  UnitEnv.userName = '游客:${kAppMeta.uuid.substring(0, 6)}';
  FxDio().auth<ScienceHost>(ScienceAuth());
  FxDio().auth<Unit3Host>(UnitApiAuth(isZh));
}

class ScienceAuth extends ApiAuth {
  @override
  FutureOr<Map<String, dynamic>> get buildHeaders => kAppMeta.toHeaderJson();
}

class UnitApiAuth extends ApiAuth {
  final bool isZh;

  UnitApiAuth(this.isZh);

  @override
  FutureOr<Map<String, dynamic>> get buildHeaders => {
        'locale': isZh ? 'zh-CN' : 'en',
      };
}
