import 'package:app/app/cons/cons.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:storage/storage.dart';
import 'package:toly_ui/code/code.dart' ;


/// create by 张风捷特烈 on 2020-04-11
/// contact me by email 1981462002@qq.com
/// 说明: 全局状态类

class AppConfigState extends Equatable {

  /// [fontFamily] 文字字体
  final String fontFamily;

  /// [themeColor] 主题色
  final ThemeColor themeColor;

  /// [showBackGround] 是否显示主页背景图
  final bool showBackGround;

  /// [codeStyleIndex] 代码样式 索引
  final int codeStyleIndex;

  /// [itemStyleIndex] 主页item样式 索引
  final int itemStyleIndex;

  /// [showPerformanceOverlay] 是否显示性能浮层
  final bool showPerformanceOverlay;

  /// [showOverlayTool] 是否显示浮动工具
  final bool showOverlayTool;

  /// [appStyle] app 深色样式;
  final ThemeMode themeMode;

  final ConnectivityResult netConnect;

  final Language language;

  const AppConfigState({
    this.fontFamily = 'ComicNeue',
    this.language = Language.zh_CN,
    this.themeColor = ThemeColor.blue,
    this.themeMode = ThemeMode.system,
    this.showBackGround = true,
    this.codeStyleIndex = 0,
    this.itemStyleIndex = 0,
    this.showPerformanceOverlay = false,
    this.showOverlayTool = true,
    this.netConnect = ConnectivityResult.none,
  });

  @override
  List<Object> get props => [
    fontFamily,
    themeColor,
    showBackGround,
    codeStyleIndex,
    itemStyleIndex,
    themeMode,
    showOverlayTool,
    showPerformanceOverlay,
    netConnect,
    language,
  ];

  AppConfigState copyWith({
    String? fontFamily,
    String? dbPath,
    ThemeColor? themeColor,
    bool? showBackGround,
    Language? language,
    int? codeStyleIndex,
    int? itemStyleIndex,
    bool? showPerformanceOverlay,
    bool? showOverlayTool,
    ThemeMode? themeMode,
    ConnectivityResult? netConnect,
  }) =>
      AppConfigState(
        fontFamily: fontFamily ?? this.fontFamily,
        language: language ?? this.language,
        themeColor: themeColor ?? this.themeColor,
        showBackGround: showBackGround ?? this.showBackGround,
        codeStyleIndex: codeStyleIndex ?? this.codeStyleIndex,
        showOverlayTool: showOverlayTool ?? this.showOverlayTool,
        itemStyleIndex: itemStyleIndex ?? this.itemStyleIndex,
        themeMode: themeMode ?? this.themeMode,
        showPerformanceOverlay: showPerformanceOverlay ?? this.showPerformanceOverlay,
        netConnect: netConnect ?? this.netConnect,
      );


  // 将 AppState 状态数据转换为配置对象，以便存储
  AppConfigPo toAppConfigPo() => AppConfigPo(
    showBackGround : showBackGround,
    showOverlayTool : showOverlayTool,
    showPerformanceOverlay : showPerformanceOverlay,
    fontFamilyIndex : Cons.kFontFamilySupport.indexOf(fontFamily),
    themeColorIndex : themeColor.index,
    codeStyleIndex : codeStyleIndex,
    themeModeIndex : themeMode.index,
    itemStyleIndex : itemStyleIndex,
    languageIndex: language.index,
  );

  // 根据存储的配置信息对象，形成 AppState 状态数据
  factory AppConfigState.fromPo(AppConfigPo po) {
    return AppConfigState(
      fontFamily: Cons.kFontFamilySupport[po.fontFamilyIndex],
      themeColor: ThemeColor.values[po.themeColorIndex],
      showBackGround: po.showBackGround,
      language: Language.values[po.languageIndex],
      codeStyleIndex:  po.codeStyleIndex,
      itemStyleIndex: po.itemStyleIndex,
      showPerformanceOverlay: po.showPerformanceOverlay,
      showOverlayTool: po.showOverlayTool,
      themeMode: ThemeMode.values[po.themeModeIndex],
    );
  }

  HighlighterStyle get codeStyle => Cons.codeThemeSupport.keys.toList()[codeStyleIndex];


  @override
  String toString() {
    return 'AppState{fontFamily: $fontFamily, themeColor: $themeColor, showBackGround: $showBackGround, codeStyleIndex: $codeStyleIndex, itemStyleIndex: $itemStyleIndex, showPerformanceOverlay: $showPerformanceOverlay}';
  }
}