import 'package:path/path.dart' as p;

class AppInfo {
  final String version;
  final String url;
  final int size;
  final String? description;
  final String? sha256;

  const AppInfo({
    required this.version,
    required this.url,
    required this.size,
    required this.description,
    required this.sha256,
  });

  String get appName => p.basename(url);

  factory AppInfo.fromMap(dynamic map) => AppInfo(
        version: map['version'] ?? '',
        url: map['url'] ?? '',
        size: map['size'] ?? 0,
        description: map['description'] ?? '',
        sha256: map['sha256'] ?? '',
      );

  @override
  String toString() {
    return 'AppInfo{appName: $appName, appVersion: $version, appUrl: $url, appSize: $size}';
  }

  bool shouldUpgrade(String current) => needsUpdate(current, version);
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
