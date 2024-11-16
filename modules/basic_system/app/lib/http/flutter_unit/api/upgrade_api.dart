import 'package:app_update/app_update.dart';
import 'package:fx_dio/fx_dio.dart';
import 'package:app/app.dart';

class UnitUpgradeApi implements UpgradeApi {
  @override
  Future<AppInfo> fetch(String appName) async {
    Dio dio = FxDio()<UnitHost>();
    Response rep = await dio.get('${UnitApi.appInfo.path}$appName');
    if (rep.statusCode == 200 && rep.data != null) {
      dynamic ret = rep.data['data'];
      // 说明有数据
      if (ret != null) {
        return AppInfo(
          appName: ret['appName'],
          appVersion: ret['appVersion'],
          appUrl: ret['appUrl'],
          appSize: ret['appSize'],
          description: ret['description'],
          sha256: ret['sha256'],
        );
      }
    }
    throw '请求错误:';
  }
}
