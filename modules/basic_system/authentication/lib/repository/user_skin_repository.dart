import 'dart:typed_data';

import 'package:shared_preferences/shared_preferences.dart';

import 'skin_storage/skin_file_store.dart';

/// 用户皮肤所属的应用亮度模式。
enum UserSkinMode {
  /// 亮色主题使用的皮肤。
  light,

  /// 暗色主题使用的皮肤。
  dark,
}

/// 管理亮色与暗色用户皮肤的文件和路径配置。
class UserSkinRepository {
  static const String _lightPathKey = 'user_header_skin_light_path';
  static const String _darkPathKey = 'user_header_skin_dark_path';

  /// 本机皮肤文件存储适配器。
  final UserSkinFileStore _fileStore;

  /// 创建用户皮肤仓库。
  UserSkinRepository({UserSkinFileStore? fileStore})
      : _fileStore = fileStore ?? UserSkinFileStore();

  /// 读取指定模式下有效的自定义皮肤路径。
  Future<String?> load(UserSkinMode mode) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? path = preferences.getString(_keyFor(mode));
    if (path == null || !await _fileStore.exists(path)) {
      return null;
    }
    return path;
  }

  /// 将图片复制到应用目录，并记录到指定主题模式。
  Future<String> save(
    UserSkinMode mode,
    Uint8List bytes,
    String extension,
  ) async {
    final String normalizedExtension = extension.toLowerCase();
    final int revision = DateTime.now().millisecondsSinceEpoch;
    final String fileName =
        'user_header_${mode.name}_$revision.$normalizedExtension';
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? previousPath = preferences.getString(_keyFor(mode));
    final String path = await _fileStore.save(fileName, bytes);
    await preferences.setString(_keyFor(mode), path);
    if (previousPath != null && previousPath != path) {
      await _fileStore.delete(previousPath);
    }
    return path;
  }

  /// 清除指定主题模式的自定义皮肤并恢复默认资源。
  Future<void> reset(UserSkinMode mode) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? path = preferences.getString(_keyFor(mode));
    await preferences.remove(_keyFor(mode));
    if (path != null) {
      await _fileStore.delete(path);
    }
  }

  String _keyFor(UserSkinMode mode) {
    return mode == UserSkinMode.light ? _lightPathKey : _darkPathKey;
  }
}
