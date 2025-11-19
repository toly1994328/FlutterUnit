import 'dart:async';

import 'package:app/app.dart';
import 'package:fx_dio/fx_dio.dart';
import 'package:unit_env/unit_env.dart' as unit;
import 'http.dart';

void registerHttpClient() {
  FxDio()
      .register(const ScienceHost(), repInterceptor: ScienceRepInterceptor());
  FxDio().register(const unit.ScienceHost());
  FxDio().register(const UnitHost());

  FxDio().auth<ScienceHost>(ScienceAuth());
}

class ScienceAuth extends ApiAuth {
  @override
  FutureOr<Map<String, dynamic>> get buildHeaders => kAppMeta.toHeaderJson();
}
