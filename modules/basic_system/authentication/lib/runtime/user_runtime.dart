import 'package:fx_user_core/fx_user_core.dart';
import 'package:fx_user_http/fx_user_http.dart';
import 'package:fx_user_preferences/fx_user_preferences.dart';
import 'package:fx_user_session/fx_user_session.dart';
import 'package:unit_env/unit_env.dart';

import 'credential_interceptor.dart';
import 'session_interceptor.dart';
import 'user_repository.dart';

/// FlutterUnit 对 FrameworkX 用户 SDK 的宿主组装入口。
abstract final class FlutterUnitUserRuntime {
  /// 组装会话存储、用户接口和启动阶段可用的认证拦截器。
  static FxUserSessionCubit create() {
    final FlutterUnitHost host = FxDio()<FlutterUnitHost>();
    final FxPreferencesUserStore userStore = FxPreferencesUserStore(
      namespace: 'flutter_unit',
    );
    final FxUserSessionCubit users = FxUserSessionCubit(
      repository: FlutterUnitUserRepository(host: host),
      credentialStore: userStore,
      snapshotStore: userStore,
      identityCodec: const FxUserIdentityCodec(),
      avatarUploadTask: HttpFxAvatarUploadTask(host: host),
      onCredentialChanged: _onCredentialChanged,
    );
    FxDio()[host].interceptors.add(FlutterUnitCredentialInterceptor());
    FxDio()[host]
        .interceptors
        .add(FlutterUnitSessionInterceptor(users: users, host: host));
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
