import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage/storage.dart';

import '../model/app_style.dart';
import '../repository/app_state_repository.dart';
import '../model/global_state.dart';

/// create by 张风捷特烈 on 2020-03-22
/// contact me by email 1981462002@qq.com
/// 说明: 全局信息的bloc

class AppBloc extends Cubit<AppState> {

  final Connectivity _connectivity = Connectivity();


  final AppStateRepository storage;
  late StreamSubscription<ConnectivityResult> _subscription;

  AppBloc(this.storage) : super(const AppState()){
    _subscription = _connectivity.onConnectivityChanged.listen(_onNetConnectChange);
  }

  void _onNetConnectChange(ConnectivityResult event) {
    emit(state.copyWith(netConnect: event,));
  }


  @override
  Future<void> close() async{
    _subscription.cancel();
    super.close();
  }


  // 程序初始化事件处理: 使用 AppStorage 进行初始化
  void initApp() async {
    emit(await storage.initApp());
  }

  AppConfigCao get cao => storage.sp.appConfig;

  // 切换字体事件处理 : 固化索引 + 产出新状态
  void switchFontFamily(String family) async {
    AppState newState = state.copyWith(fontFamily: family);
    cao.write(newState.toAppConfigPo());
    emit(newState);
  }

  // 切换主题色事件处理 : 固化索引 + 产出新状态
  void switchThemeColor(MaterialColor color) async {
    AppState newState = state.copyWith(themeColor: color);
    cao.write(newState.toAppConfigPo());
    emit(newState);
  }

  // 切换背景显示事件处理 : 固化数据 + 产出新状态
  void switchShowBg(bool show) async {
    AppState newState = state.copyWith(showBackGround: show);
    cao.write(newState.toAppConfigPo());
    emit(newState);
  }

  // 切换背景显示事件处理 : 产出新状态
  void switchShowOver(bool show) async {
    AppState newState = state.copyWith(showPerformanceOverlay: show);
    cao.write(newState.toAppConfigPo());
    emit(newState);
  }

  // 切换code样式事件处理 : 固化索引 + 产出新状态
  void switchCoderTheme(int codeStyleIndex) async {
    AppState newState = state.copyWith(codeStyleIndex: codeStyleIndex);
    cao.write(newState.toAppConfigPo());
    emit(newState);
  }

  // 切换item样式事件处理 : 固化索引 + 产出新状态
  void changeItemStyle(int index) async {
    AppState newState = state.copyWith(itemStyleIndex: index);
    cao.write(newState.toAppConfigPo());
    emit(newState);
  }

  void changeThemeMode(ThemeMode style) async{
    AppState newState = state.copyWith(themeMode: style);
    cao.write(newState.toAppConfigPo());
    emit(newState);
  }

  void switchShowTool(bool show) async{
    AppState newState = state.copyWith(showOverlayTool: show);
    cao.write(newState.toAppConfigPo());
    emit(newState);
  }
}
