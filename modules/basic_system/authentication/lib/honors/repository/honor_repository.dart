import 'package:unit_env/unit_env.dart';

import '../model/user_honor.dart';

/// FlutterUnit 用户荣誉接口。
class HonorRepository {
  HonorRepository({RequestHost<HostEnv>? host})
      : _host = host ?? FxDio()<FlutterUnitHost>();

  /// FlutterUnit 的统一请求 Host。
  final RequestHost<HostEnv> _host;

  /// 获取当前用户的全部奖励。
  Future<ApiRet<List<UserHonor>>> loadMyHonors() {
    return _host.get<List<UserHonor>>(
      '/user/honors',
      convertor: _parseHonorList,
    );
  }

  /// 装备一个已经获得的头像框。
  Future<ApiRet<UserHonor?>> equipAvatarFrame(String code) {
    return _host.put<UserHonor?>(
      '/user/honors/avatar-frame',
      data: {'code': code},
      convertor: _parseAvatarFrame,
    );
  }

  /// 卸下当前头像框。
  Future<ApiRet<UserHonor?>> unequipAvatarFrame() {
    return _host.delete<UserHonor?>(
      '/user/honors/avatar-frame',
      convertor: _parseAvatarFrame,
    );
  }

  /// 装配一枚已经获得的徽章。
  Future<ApiRet<List<UserHonor>>> equipBadge(String code) {
    return _host.put<List<UserHonor>>(
      '/user/honors/badges/$code',
      convertor: _parseEquippedBadges,
    );
  }

  /// 取消装配一枚徽章。
  Future<ApiRet<List<UserHonor>>> unequipBadge(String code) {
    return _host.delete<List<UserHonor>>(
      '/user/honors/badges/$code',
      convertor: _parseEquippedBadges,
    );
  }

  List<UserHonor> _parseHonorList(dynamic data) {
    final Map<String, dynamic> map = Map<String, dynamic>.from(data as Map);
    final List<dynamic> items = List<dynamic>.from(map['items'] as List? ?? []);
    return items.map<UserHonor>(UserHonor.fromApi).toList();
  }

  UserHonor? _parseAvatarFrame(dynamic data) {
    final Map<String, dynamic> map = Map<String, dynamic>.from(data as Map);
    final dynamic frame = map['avatar_frame'];
    return frame == null ? null : UserHonor.fromApi(frame);
  }

  List<UserHonor> _parseEquippedBadges(dynamic data) {
    final Map<String, dynamic> map = Map<String, dynamic>.from(data as Map);
    final List<dynamic> badges =
        List<dynamic>.from(map['badges'] as List? ?? []);
    return badges.map<UserHonor>(UserHonor.fromApi).toList();
  }
}
