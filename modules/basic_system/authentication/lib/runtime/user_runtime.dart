import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fx_user_core/fx_user_core.dart';
import 'package:fx_user_http/fx_user_http.dart';
import 'package:fx_user_preferences/fx_user_preferences.dart';
import 'package:fx_user_session/fx_user_session.dart';
import 'package:unit_env/unit_env.dart';

/// FlutterUnit 对 FrameworkX 用户 SDK 的宿主组装入口。
abstract final class FlutterUnitUserRuntime {
  static FxUserSessionCubit create() {
    final FlutterUnitHost host = FxDio()<FlutterUnitHost>();
    final FxPreferencesUserStore userStore = FxPreferencesUserStore(
      namespace: 'flutter_unit',
    );
    final FxUserSessionCubit users = FxUserSessionCubit(
      repository: HttpFxUserRepository(host: host),
      credentialStore: userStore,
      snapshotStore: userStore,
      identityCodec: const FxUserIdentityCodec(),
      avatarUploadTask: HttpFxAvatarUploadTask(host: host),
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
