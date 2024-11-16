import '../../model/app_info.dart';

abstract class UpgradeApi {
  Future<AppInfo> fetch(String appName);

}
