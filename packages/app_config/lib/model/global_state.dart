import 'package:app_config/app/cons/cons.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:storage/storage.dart';

import 'app_style.dart';

/// create by 张风捷特烈 on 2020-04-11
/// contact me by email 1981462002@qq.com
/// 说明: 全局状态类
///
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

  /// [appStyle] app 样式;
  final AppStyle appStyle;

  const AppState({
    this.fontFamily = 'ComicNeue',
    this.themeColor = Colors.blue,
    this.appStyle = AppStyle.standard,
    this.showBackGround = true,
    this.codeStyleIndex = 0,
    this.itemStyleIndex = 0,
    this.showPerformanceOverlay = false,
    this.showOverlayTool = true,
  });

  @override
  List<Object> get props => [
        fontFamily,
        themeColor,
        showBackGround,
        codeStyleIndex,
        itemStyleIndex,
        appStyle,
        showOverlayTool,
        showPerformanceOverlay
      ];

  AppState copyWith({
    String? fontFamily,
    MaterialColor? themeColor,
    bool? showBackGround,
    int? codeStyleIndex,
    int? itemStyleIndex,
    bool? showPerformanceOverlay,
    bool? showOverlayTool,
    AppStyle? appStyle,
  }) =>
      AppState(
        fontFamily: fontFamily ?? this.fontFamily,
        themeColor: themeColor ?? this.themeColor,
        showBackGround: showBackGround ?? this.showBackGround,
        codeStyleIndex: codeStyleIndex ?? this.codeStyleIndex,
        showOverlayTool: showOverlayTool ?? this.showOverlayTool,
        itemStyleIndex: itemStyleIndex ?? this.itemStyleIndex,
        appStyle: appStyle ?? this.appStyle,
        showPerformanceOverlay: showPerformanceOverlay ?? this.showPerformanceOverlay,
      );


  // 将 AppState 状态数据转换为配置对象，以便存储
  AppConfigPo toAppConfigPo() => AppConfigPo(
    showBackGround : showBackGround,
    showOverlayTool : showOverlayTool,
    showPerformanceOverlay : showPerformanceOverlay,
    fontFamilyIndex : Cons.kFontFamilySupport.indexOf(fontFamily),
    themeColorIndex : Cons.kThemeColorSupport.keys.toList().indexOf(themeColor),
    codeStyleIndex : codeStyleIndex,
    appStyleIndex : appStyle.index,
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
        appStyle: AppStyle.values[po.appStyleIndex],
    );
  }

  @override
  String toString() {
    return 'AppState{fontFamily: $fontFamily, themeColor: $themeColor, showBackGround: $showBackGround, codeStyleIndex: $codeStyleIndex, itemStyleIndex: $itemStyleIndex, showPerformanceOverlay: $showPerformanceOverlay}';
  }
}
