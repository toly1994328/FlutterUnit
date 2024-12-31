import 'package:app/app.dart';

import '../model/app_info.dart';
import 'package:fx_dio/fx_dio.dart';

typedef OnProgressChange = void Function(double progress);

abstract class UpgradeApi with CheckUpgrade {}

mixin CheckUpgrade {
  Future<ApiRet<AppInfo>> fetch(int appId);
}
