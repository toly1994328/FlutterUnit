import 'package:app/app/cons/cons.dart';
import 'package:components/toly_ui/toly_ui.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:storage/storage.dart';

import 'app_style.dart';

/// create by 张风捷特烈 on 2020-04-11
/// contact me by email 1981462002@qq.com
/// 说明: 全局状态类

Map<ThemeMode,String> themeMode2Str = const {
  ThemeMode.system: "跟随系统",
  ThemeMode.light: "浅色模式",
  ThemeMode.dark: "深色模式",
};

class AppState extends Equatable {

  /// [fontFamily] 文字字体
  final String fontFamily;

  /// [themeColor] 主题色
  final MaterialColor themeColor;

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
  final String dbPath;

  const AppState({
    this.fontFamily = 'ComicNeue',
    this.themeColor = Colors.blue,
    this.themeMode = ThemeMode.system,
    this.showBackGround = true,
    this.codeStyleIndex = 0,
    this.itemStyleIndex = 0,
    this.showPerformanceOverlay = false,
    this.showOverlayTool = true,
    this.dbPath = '',
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
      ];

  AppState copyWith({
    String? fontFamily,
    String? dbPath,
    MaterialColor? themeColor,
    bool? showBackGround,
    int? codeStyleIndex,
    int? itemStyleIndex,
    bool? showPerformanceOverlay,
    bool? showOverlayTool,
    ThemeMode? themeMode,
    ConnectivityResult? netConnect,
  }) =>
      AppState(
        fontFamily: fontFamily ?? this.fontFamily,
        themeColor: themeColor ?? this.themeColor,
        showBackGround: showBackGround ?? this.showBackGround,
        codeStyleIndex: codeStyleIndex ?? this.codeStyleIndex,
        showOverlayTool: showOverlayTool ?? this.showOverlayTool,
        itemStyleIndex: itemStyleIndex ?? this.itemStyleIndex,
        themeMode: themeMode ?? this.themeMode,
        showPerformanceOverlay: showPerformanceOverlay ?? this.showPerformanceOverlay,
        netConnect: netConnect ?? this.netConnect,
        dbPath: dbPath ?? this.dbPath,
      );


  // 将 AppState 状态数据转换为配置对象，以便存储
  AppConfigPo toAppConfigPo() => AppConfigPo(
    showBackGround : showBackGround,
    showOverlayTool : showOverlayTool,
    showPerformanceOverlay : showPerformanceOverlay,
    fontFamilyIndex : Cons.kFontFamilySupport.indexOf(fontFamily),
    themeColorIndex : Cons.kThemeColorSupport.keys.toList().indexOf(themeColor),
    codeStyleIndex : codeStyleIndex,
    themeModeIndex : themeMode.index,
    itemStyleIndex : itemStyleIndex,
  );

  // 根据存储的配置信息对象，形成 AppState 状态数据
  factory AppState.fromPo(AppConfigPo po) {
    return AppState(
        fontFamily: Cons.kFontFamilySupport[po.fontFamilyIndex],
        themeColor: Cons.kThemeColorSupport.keys.toList()[po.themeColorIndex],
        showBackGround: po.showBackGround,
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
