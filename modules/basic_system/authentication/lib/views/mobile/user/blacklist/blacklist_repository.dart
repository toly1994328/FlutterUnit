import 'package:unit_env/unit_env.dart';

import 'blocked_user.dart';

/// 黑名单接口访问边界。
class BlacklistRepository with FlutterUnitHostMixin {
  Future<ApiRet<List<BlockedUser>>> load() {
    return host.get<List<BlockedUser>>(
      '/moderation/blocked-users',
      convertor: (dynamic data) {
        final List<dynamic> values = data as List<dynamic>;
        return values
            .map(
              (dynamic value) =>
                  BlockedUser.fromJson(value as Map<String, dynamic>),
            )
            .toList();
      },
    );
  }

  Future<ApiRet<dynamic>> unblock(int userId) {
    return host.delete<dynamic>(
      '/moderation/blocked-users/$userId',
      convertor: (dynamic data) => data,
    );
  }
}
