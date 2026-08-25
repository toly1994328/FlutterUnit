import 'dart:async';

import 'package:app/app.dart';
import 'package:fx_dio/fx_dio.dart';
import 'package:unit_env/unit_env.dart';
import 'http.dart';

void registerHttpClient(bool isZh) {
  FxDio().register(
    const FlutterUnitHost(),
    repInterceptor: FlutterUnitResponseInterceptor(),
  );
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
      };
}
