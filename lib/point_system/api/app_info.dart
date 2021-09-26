import 'package:flutter_unit/app/res/path_unit.dart';
import 'package:flutter_unit/app/utils/http_utils/http_util.dart';
import 'package:flutter_unit/app/utils/http_utils/result_bean.dart';

class AppInfoApi {

  static Future<ResultBean<AppInfo>> getAppVersion() async {
    String errorMsg = "";
    var result = await HttpUtil.getInstance()
        .client
        .get(PathUnit.appInfo)
        .catchError((err) {
      errorMsg = err.toString();
    });

    // 获取的数据非空且 status = true
    if (result.data != null && result.data['status']) {
      // 说明有数据
      if (result.data['data'] != null) {
        return ResultBean.ok<AppInfo>(
            AppInfo(
              appName: result.data['data']['appName'],
              appVersion: result.data['data']['appVersion'],
              appUrl: result.data['data']['appUrl'],
            ));
      } else {
        return ResultBean.ok<AppInfo>(null);
      }
    }
    return ResultBean.error('请求错误: $errorMsg');
  }
}

class AppInfo{
  final String appName;
  final String appVersion;
  final String appUrl;

  AppInfo({
    required this.appName,
    required this.appVersion,
    required this.appUrl,
  });
}