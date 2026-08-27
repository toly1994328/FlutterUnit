import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fx_user_core/fx_user_core.dart';
import 'package:fx_user_http/fx_user_http.dart';
import 'package:fx_user_session/fx_user_session.dart';
import 'package:unit_env/unit_env.dart';

import 'session_store.dart';

/// FlutterUnit 用户公开身份投影。
final class FlutterUnitIdentity implements FxIdentity {
  @override
  final String id;

  @override
  final String? displayName;

  @override
  final Uri? avatar;

  /// 用户资料扩展字段。
  final Map<String, dynamic> profile;

  const FlutterUnitIdentity({
    required this.id,
    required this.displayName,
    required this.avatar,
    required this.profile,
  });

  @override
  T? read<T>(FxIdentityField<T> field) => profile[field.name] as T?;
}

/// 将 FrameworkX 用户模型投影为 FlutterUnit 可公开消费的身份。
final class FlutterUnitIdentityCodec implements FxIdentityCodec<FxUser> {
  const FlutterUnitIdentityCodec();

  @override
  FxIdentity decode(FxUser user) => FlutterUnitIdentity(
        id: user.id,
        displayName: user.displayName,
        avatar: user.avatar,
        profile: user.profile,
      );
}

/// FlutterUnit 对 FrameworkX 用户 SDK 的宿主组装入口。
abstract final class FlutterUnitUserRuntime {
  static FxUserSessionCubit create() {
    final FlutterUnitHost host = FxDio()<FlutterUnitHost>();
    final FxUserSessionCubit users = FxUserSessionCubit(
      repository: HttpFxUserRepository(host: host),
      credentialStore: FlutterUnitCredentialStore(),
      snapshotStore: FlutterUnitUserSnapshotStore(),
      identityCodec: const FlutterUnitIdentityCodec(),
      onCredentialChanged: _onCredentialChanged,
    );
    FxDio()[host].interceptors.add(
      InterceptorsWrapper(
        onError: (DioException error, ErrorInterceptorHandler handler) {
          final String? failedAuthorization =
              error.requestOptions.headers['Authorization']?.toString();
          final UserCredential? credential = users.credential;
          final bool currentCredentialFailed = credential is BearerCredential &&
              failedAuthorization == 'Bearer ${credential.accessToken}';
          if (error.response?.statusCode == 401 && currentCredentialFailed) {
            unawaited(users.handleUnauthorized());
          }
          handler.next(error);
        },
      ),
    );
    return users;
  }

  /// 将 SDK 凭据同步给 FlutterUnit 的统一请求认证头。
  static void _onCredentialChanged(UserCredential? credential) {
    UnitEnv.accessToken = switch (credential) {
      BearerCredential(:final String accessToken) => accessToken,
      _ => null,
    };
  }
}
