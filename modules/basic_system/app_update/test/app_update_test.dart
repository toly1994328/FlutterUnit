import 'package:app/app.dart';
import 'package:app_update/app_update.dart';
import 'package:fx_dio/fx_dio.dart';

void main() async {
  FxDio().register(const UnitHost());

  Host host = FxDio()<UnitHost>();
  String path = UnitApi.appInfo.path;
  ApiRet<AppInfo> info = await host.get<AppInfo>(path, queryParameters: {
    'app_id': 1,
    'os': kAppEnv.os.name,
  }, convertor: (dynamic data) => AppInfo.fromMap(data['data']));
  print(info.data);
}
