import 'package:app/app.dart';
import 'package:app_update/app_update.dart';
import 'package:fx_dio/fx_dio.dart';

void main() async {
  FxDio().register(const ScienceHost(), repInterceptor: ScienceRepInterceptor());

  UpgradeApi api = UnitUpgradeApi();
  ApiRet<AppInfo> info = await api.fetch(1);
  print(info.data);
}
