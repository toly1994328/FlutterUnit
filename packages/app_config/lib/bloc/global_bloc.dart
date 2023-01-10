import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/app_style.dart';
import '../repository/app_state_repository.dart';
import '../model/global_state.dart';

/// create by 张风捷特烈 on 2020-03-22
/// contact me by email 1981462002@qq.com
/// 说明: 全局信息的bloc

class AppBloc extends Cubit< AppState> {

  final AppStateRepository storage;

  AppBloc(this.storage) : super(const AppState());

  // 程序初始化事件处理: 使用 AppStorage 进行初始化
  void initApp() async {
    emit(await storage.initApp());
  }

  // 切换字体事件处理 : 固化索引 + 产出新状态
  void switchFontFamily(String family) async {
    storage.saveFontFamily(family);
    emit(state.copyWith(fontFamily: family));
  }

  // 切换主题色事件处理 : 固化索引 + 产出新状态
  void switchThemeColor(MaterialColor color) async {
    storage.saveThemeColor(color);
    emit(state.copyWith(themeColor: color));
  }

  // 切换背景显示事件处理 : 固化数据 + 产出新状态
  void switchShowBg(bool show) async {
    storage.saveShowBg(show);
    emit(state.copyWith(showBackGround: show));
  }

  // 切换背景显示事件处理 : 产出新状态
  void switchShowOver(bool show) async {
    emit(state.copyWith(showPerformanceOverlay: show));
  }

  // 切换code样式事件处理 : 固化索引 + 产出新状态
  void switchCoderTheme(int codeStyleIndex) async {
    storage.saveCoderTheme(codeStyleIndex);
    emit(state.copyWith(codeStyleIndex: codeStyleIndex));
  }

  // 切换item样式事件处理 : 固化索引 + 产出新状态
  void changeItemStyle(int index) async {
    storage.saveItemStyle(index);
    emit(state.copyWith(itemStyleIndex: index));
  }

  void changeAppStyle(AppStyle style) async{
    storage.saveChangeAppStyle(style);
    emit(state.copyWith(appStyle:style));

  }

  void switchShowTool(bool show) async{
    storage.saveShowTool(show);
    emit(state.copyWith(showOverlayTool: show));
  }
}
