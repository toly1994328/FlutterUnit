import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fx_user_core/fx_user_core.dart';
import 'package:fx_user_session/fx_user_session.dart';
import 'package:unit_env/unit_env.dart';

/// 区分业务操作校验失败和会话失效，避免旧密码错误导致正常账号退出。
class FlutterUnitSessionInterceptor extends Interceptor {
  FlutterUnitSessionInterceptor(
      {required FxUserSessionCubit users, required FlutterUnitHost host})
      : _users = users,
        _host = host;

  /// 当前会话的唯一拥有者。
  final FxUserSessionCubit _users;

  /// 已注册统一响应转换器的请求宿主。
  final FlutterUnitHost _host;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final String? authorization =
        err.requestOptions.headers['Authorization']?.toString();
    if (err.response?.statusCode == 401 &&
        _usesCurrentCredential(authorization)) {
      if (Uri.parse(err.requestOptions.path).path.endsWith('/user/profile')) {
        unawaited(_users.handleUnauthorized());
      } else {
        unawaited(_verifySession(authorization!));
      }
    }
    handler.next(err);
  }

  /// 旧会话返回的错误不能影响随后登录的新账号。
  bool _usesCurrentCredential(String? authorization) {
    final UserCredential? credential = _users.credential;
    return credential is BearerCredential &&
        authorization == 'Bearer ${credential.accessToken}';
  }

  /// 业务接口的 401 可能只是旧密码错误；仅资料接口确认失效时才清理会话。
  Future<void> _verifySession(String authorization) async {
    if (!_usesCurrentCredential(authorization)) return;
    try {
      await FxDio()[_host].get<dynamic>('/user/profile',
          options: Options(
            headers: <String, dynamic>{'Authorization': authorization},
          ));
    } on DioException {
      // 资料接口的 401 已由 onError 处理，网络故障或服务错误保留现有会话。
    }
  }
}
