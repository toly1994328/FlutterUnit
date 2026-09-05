import 'package:unit_env/unit_env.dart';

import '../model/progression_item.dart';

/// FlutterUnit 每日任务与成就接口。
class ProgressionRepository {
  ProgressionRepository({RequestHost<HostEnv>? host})
      : _host = host ?? FxDio()<FlutterUnitHost>();

  /// FlutterUnit 的统一请求 Host。
  final RequestHost<HostEnv> _host;

  /// 查询当前用户的每日任务和长期成就。
  Future<ApiRet<ProgressionOverview>> loadOverview() {
    return _host.get<ProgressionOverview>(
      '/user/progression/overview',
      convertor: ProgressionOverview.fromApi,
    );
  }

  /// 完成或查询今日签到状态。
  Future<ApiRet<ProgressionOverview>> checkIn() {
    return _host.post<ProgressionOverview>(
      '/user/progression/check-in',
      convertor: _parseCheckIn,
    );
  }

  /// 领取一个已经完成的每日任务奖励。
  Future<ApiRet<ProgressionOverview>> claimDailyTask(String code) {
    return _host.post<ProgressionOverview>(
      '/user/progression/daily-tasks/$code/claim',
      convertor: ProgressionOverview.fromApi,
    );
  }

  /// 上报已经打开的组件，由服务端按组件 ID 去重计算进度。
  Future<ApiRet<bool>> recordWidgetView(int widgetId) {
    return _host.post<bool>(
      '/user/progression/widgets/$widgetId/view',
    );
  }

  /// 上报组件首次收藏，由服务端按组件 ID 去重计算进度。
  Future<ApiRet<bool>> recordWidgetCollection(int widgetId) {
    return _host.post<bool>(
      '/user/progression/widgets/$widgetId/collect',
    );
  }

  ProgressionOverview _parseCheckIn(dynamic data) {
    final Map<String, dynamic> map = Map<String, dynamic>.from(data as Map);
    return ProgressionOverview.fromApi(map['overview']);
  }
}
