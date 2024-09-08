// 用于维护 App 配置信息的存储类
// 配置信息将通过 sp 存储在 xml 中
class AppConfigPo {
  final bool showBackGround;
  final bool showOverlayTool;
  final bool showPerformanceOverlay;
  final int fontFamilyIndex;
  final int languageIndex;
  final int codeStyleIndex;
  final int themeModeIndex;
  final int itemStyleIndex;
  final int themeColorIndex;

  AppConfigPo({
    this.showBackGround = false,
    this.showOverlayTool = false,
    this.showPerformanceOverlay = false,
    this.fontFamilyIndex = 1,
    this.languageIndex = 0,
    this.themeColorIndex = 4,
    this.codeStyleIndex = 0,
    this.themeModeIndex = 0,
    this.itemStyleIndex = 0,
  });

  factory AppConfigPo.fromPo(dynamic map) {
    return AppConfigPo(
      showBackGround: map['showBackGround'] ?? false,
      showOverlayTool: map['showOverlayTool'] ?? false,
      showPerformanceOverlay: map['showPerformanceOverlay'] ?? false,
      fontFamilyIndex: map['fontFamilyIndex'] ?? 1,
      themeColorIndex: map['themeColorIndex'] ?? 4,
      codeStyleIndex: map['codeStyleIndex'] ?? 0,
      themeModeIndex: map['themeModeIndex'] ?? 0,
      itemStyleIndex: map['itemStyleIndex'] ?? 0,
      languageIndex: map['languageIndex'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'showBackGround': showBackGround,
        'showOverlayTool': showOverlayTool,
        'showPerformanceOverlay': showPerformanceOverlay,
        'fontFamilyIndex': fontFamilyIndex,
        'themeColorIndex': themeColorIndex,
        'codeStyleIndex': codeStyleIndex,
        'themeModeIndex': themeModeIndex,
        'itemStyleIndex': itemStyleIndex,
        'languageIndex': languageIndex,
      };
}
