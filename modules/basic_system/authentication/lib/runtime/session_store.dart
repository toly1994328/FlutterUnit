import 'dart:convert';

import 'package:fx_user_core/fx_user_core.dart';
import 'package:fx_user_session/fx_user_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// FlutterUnit 的 FrameworkX 凭据持久化实现。
final class FlutterUnitCredentialStore implements AuthCredentialStore {
  static const String _key = 'flutter_unit.user.session.v1';

  /// 异步配置存储，避免与旧同步缓存实例共享状态。
  final SharedPreferencesAsync preferences;

  FlutterUnitCredentialStore({SharedPreferencesAsync? preferences})
      : preferences = preferences ?? SharedPreferencesAsync();

  @override
  Future<UserCredential?> read() async {
    final String? source = await preferences.getString(_key);
    if (source == null || source.isEmpty) return null;
    try {
      return UserCredential.fromJson(
        Map<String, dynamic>.from(jsonDecode(source) as Map),
      );
    } catch (_) {
      await clear();
      return null;
    }
  }

  @override
  Future<void> write(UserCredential credential) {
    return preferences.setString(_key, jsonEncode(credential.toJson()));
  }

  @override
  Future<void> clear() => preferences.remove(_key);
}

/// FlutterUnit 的 FrameworkX 用户资料快照存储。
final class FlutterUnitUserSnapshotStore implements UserSnapshotStore {
  static const String _key = 'flutter_unit.user.snapshot.v1';

  /// 异步配置存储。
  final SharedPreferencesAsync preferences;

  FlutterUnitUserSnapshotStore({SharedPreferencesAsync? preferences})
      : preferences = preferences ?? SharedPreferencesAsync();

  @override
  Future<FxUser?> readSnapshot() async {
    final String? source = await preferences.getString(_key);
    if (source == null || source.isEmpty) return null;
    try {
      return FxUser.fromJson(
        Map<String, dynamic>.from(jsonDecode(source) as Map),
      );
    } catch (_) {
      await clearSnapshot();
      return null;
    }
  }

  @override
  Future<void> writeSnapshot(FxUser user) {
    return preferences.setString(_key, jsonEncode(user.toJson()));
  }

  @override
  Future<void> clearSnapshot() => preferences.remove(_key);
}
