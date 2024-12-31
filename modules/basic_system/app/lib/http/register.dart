import 'package:fx_dio/fx_dio.dart';
import 'http.dart';

void registerHttpClient(){
  FxDio().register(const ScienceHost(), repInterceptor: ScienceRepInterceptor());
  FxDio().register(const UnitHost());
}