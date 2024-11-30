import 'package:app_update/app_update.dart';
import 'package:fx_dio/fx_dio.dart';
import 'package:app/app.dart';
import 'package:tolyui/tolyui.dart';

class UnitUpgradeApi implements UpgradeApi {
  @override
  Future<ApiRet<AppInfo>> fetch(String appName) async {
    Host unit = FxDio()<UnitHost>();
    return unit.get<AppInfo>('${UnitApi.appInfo.path}$appName', queryParameters: {
      'os': kAppEnv.os.name,
    }, convertor: (dynamic data) {
      dynamic ret = data['data'];
      return AppInfo(
        appName: ret['appName'],
        appVersion: ret['appVersion'],
        appUrl: ret['appUrl'],
        appSize: ret['appSize'],
        description: ret['description'],
        sha256: ret['sha256'],
      );
    });
  }

  @override
  void toast(String message) {
    $message.warning(message: message);
  }
}
