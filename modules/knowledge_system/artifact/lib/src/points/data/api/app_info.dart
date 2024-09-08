import 'package:app/app.dart';
import 'package:equatable/equatable.dart';
import 'package:utils/utils.dart';

class AppInfoApi {

  static Future<TaskResult<AppInfo>> getAppVersion({required String appName}) async {
    String errorMsg = "";
    var result = await HttpUtil.instance
        .client
        .get(PathUnit.appInfo+"/$appName")
        .catchError((err) {
      errorMsg = err.toString();
    });

    // 获取的数据非空且 status = true
    if (result.data != null && result.data['status']) {
      // 说明有数据
      if (result.data['data'] != null) {
        return TaskResult.success(
           data: AppInfo(
              appName: result.data['data']['appName'],
              appVersion: result.data['data']['appVersion'],
              appUrl: result.data['data']['appUrl'],
              appSize: result.data['data']['appSize'],
            ));
      } else {
        return const TaskResult.success(data: null);
      }
    }
    return TaskResult.error(msg: '请求错误: $errorMsg');
  }
}

class AppInfo extends Equatable{
  final String appName;
  final String appVersion;
  final String appUrl;
  final int appSize;

  const AppInfo({
    required this.appName,
    required this.appVersion,
    required this.appUrl,
    required this.appSize,
  });

  @override
  List<Object?> get props => [appName,appVersion,appUrl,appSize];

  @override
  String toString() {
    return 'AppInfo{appName: $appName, appVersion: $appVersion, appUrl: $appUrl, appSize: $appSize}';
  }
}