import 'package:equatable/equatable.dart';

class AppInfo extends Equatable {
  final String appName;
  final String appVersion;
  final String appUrl;
  final int appSize;
  final String? description;
  final String? sha256;

  const AppInfo({
    required this.appName,
    required this.appVersion,
    required this.appUrl,
    required this.appSize,
    required this.description,
    required this.sha256,
  });

  @override
  List<Object?> get props => [appName, appVersion, appUrl, appSize];

  @override
  String toString() {
    return 'AppInfo{appName: $appName, appVersion: $appVersion, appUrl: $appUrl, appSize: $appSize}';
  }

  bool shouldUpgrade(String current) => needsUpdate(current, appVersion);
}

bool needsUpdate(
  String oldVersion,
  String newVersion, {
  int versionParts = 3, // 默认三位版本号
  String prefix = '', // 默认无前缀
}) {
  // 去除版本号前缀并将其解析为整数列表
  List<int> parseVersion(String version) {
    if (prefix.isNotEmpty && version.startsWith(prefix)) {
      version = version.substring(prefix.length); // 移除前缀
    }

    final parts = version.split('.');
    if (parts.length != versionParts) {
      throw FormatException(
          '版本号格式错误，应为包含 $versionParts 位版本号的格式，如 ${prefix}1.0.0');
    }

    return parts.map(int.parse).toList();
  }

  final oldParts = parseVersion(oldVersion);
  final newParts = parseVersion(newVersion);

  // 按位比较版本号
  for (int i = 0; i < versionParts; i++) {
    if (newParts[i] > oldParts[i]) {
      return true; // 新版本号更大，需要更新
    } else if (newParts[i] < oldParts[i]) {
      return false; // 新版本号更小，不需要更新
    }
  }

  // 版本号相同，不需要更新
  return false;
}
