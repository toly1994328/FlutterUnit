import '../../model/app_info.dart';

abstract class UpgradeApi with CheckUpgrade, Toaster {

}

mixin CheckUpgrade {
  Future<AppInfo> fetch(String appName);
}

mixin Toaster {
  void toast(String message);
}
