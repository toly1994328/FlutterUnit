import 'package:path/path.dart' as path;

class IconFontGenConfig {
  final String srcZip;
  final String projectPath;
  final String assetsDist;
  final String fileDist;

  IconFontGenConfig({
    this.srcZip = '',
    this.projectPath = '',
    String? assetsDist,
    String? fileDist,
  })  : fileDist = fileDist ?? 'lib${spa}app${spa}gen${spa}toly_icon.dart',
        assetsDist = assetsDist ?? 'assets${spa}iconfont';

  static String get spa => path.separator;

  String get distFilePath => path.join(projectPath, fileDist);

  String get distAssetsDir => path.join(projectPath, assetsDist);

  String get ttfDistPath => path.join(distAssetsDir, path.basenameWithoutExtension(fileDist)+".ttf");

  String get yamlAssetDist => assetsDist.replaceAll('\\', '/')+"/"+path.basename(ttfDistPath);

  String get fontFamily => path
      .basenameWithoutExtension(fileDist)
      .split('_')
      .map((e) => e[0].toUpperCase() + e.substring(1,))
      .join('');

  factory IconFontGenConfig.fromJson(Map<String, dynamic> map) {
    return IconFontGenConfig(
        srcZip: map['srcZip'] ?? '',
        projectPath: map['projectPath'] ?? '',
        assetsDist: map["assetsDist"] ?? '',
        fileDist: map["fileDist"] ?? '');
  }

  Map<String, dynamic> toJson() => {
        'srcZip': srcZip,
        'projectPath': projectPath,
        'assetsDist': assetsDist,
        'fileDist': fileDist,
      };
}
