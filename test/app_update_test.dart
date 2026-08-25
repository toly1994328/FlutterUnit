import 'package:app/app.dart';
import 'package:fx_dio/fx_dio.dart';
import 'package:fx_updater/fx_updater.dart';

void main() async {
  FxDio().register(
    const FlutterUnitHost(),
    repInterceptor: FlutterUnitResponseInterceptor(),
  );

  UpgradeApi api = UnitUpgradeApi();
  ApiRet<AppInfo> info = await api.fetch(1, 'zh');
  print(info.data);
}
