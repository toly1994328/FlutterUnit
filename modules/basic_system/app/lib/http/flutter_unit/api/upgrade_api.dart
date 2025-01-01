import 'dart:async';
import 'package:app_update/app_update.dart';
import 'package:fx_dio/fx_dio.dart';
import 'package:app/app.dart';

class UnitUpgradeApi implements UpgradeApi {
  @override
  Future<ApiRet<AppInfo>> fetch(int appId,String locale) async {
    Host host = FxDio()<ScienceHost>();
    String path = ScienceApi.appVersion.path;
    return host.get<AppInfo>(
      path,
      queryParameters: {
        'app_id': 1,
        'os': kAppEnv.os.name,
        'locale': locale,
      },
      convertor: AppInfo.fromMap,
    );
  }
}
