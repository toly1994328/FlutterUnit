import '../../model/app_info.dart';
import 'package:fx_dio/fx_dio.dart';
abstract class UpgradeApi with CheckUpgrade, Toaster {

}

mixin CheckUpgrade {
  Future<ApiRet<AppInfo>> fetch(String appName);
}

mixin Toaster {
  void toast(String message);
}
