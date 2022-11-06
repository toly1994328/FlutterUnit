import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/res/cons/cons.dart';
import 'package:flutter_unit/app/res/cons/sp.dart';
import 'package:flutter_unit/app/res/theme/app_style.dart';
import 'package:flutter_unit/app/storage/app_start.dart';
import 'package:flutter_unit/app/storage/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'global_event.dart';
import 'global_state.dart';

/// create by 张风捷特烈 on 2020-03-22
/// contact me by email 1981462002@qq.com
/// 说明: 全局信息的bloc

class AppBloc extends Bloc<GlobalEvent, AppState> {

  final AppStart storage;

  AppBloc(this.storage) : super(const AppState()) {
    on<EventInitApp>(_onEventInitApp);
    on<EventSwitchFontFamily>(_onEventSwitchFontFamily);
    on<EventSwitchThemeColor>(_onEventSwitchThemeColor);
    on<EventSwitchShowBg>(_onEventSwitchShowBg);
    on<EventSwitchShowOver>(_onEventSwitchShowOver);
    on<EventSwitchCoderTheme>(_onEventSwitchCoderTheme);
    on<EventChangeItemStyle>(_onEventChangeItemStyle);
    on<EventChangeAppStyle>(_onEventChangeAppStyle);
    on<EventSwitchShowTool>(_onEventSwitchShowTool);
  }

  Future<SharedPreferences> get sp => LocalStorage.sp;

  // 程序初始化事件处理: 使用 AppStorage 进行初始化
  void _onEventInitApp(EventInitApp event, Emitter<AppState> emit) async {
    emit(await storage.initApp());
  }

  // 切换字体事件处理 : 固化索引 + 产出新状态
  void _onEventSwitchFontFamily(
      EventSwitchFontFamily event, Emitter<AppState> emit) async {
    int familyIndex = Cons.kFontFamilySupport.indexOf(event.family);
    (await sp).setInt(SP.fontFamily, familyIndex);
    emit(state.copyWith(fontFamily: event.family));
  }

  // 切换主题色事件处理 : 固化索引 + 产出新状态
  void _onEventSwitchThemeColor(
      EventSwitchThemeColor event, Emitter<AppState> emit) async {
    int themeIndex = Cons.kThemeColorSupport.keys.toList().indexOf(event.color);
    (await sp).setInt(SP.themeColorIndex, themeIndex);
    emit(state.copyWith(themeColor: event.color));
  }

  // 切换背景显示事件处理 : 固化数据 + 产出新状态
  void _onEventSwitchShowBg(
      EventSwitchShowBg event, Emitter<AppState> emit) async {
    (await sp).setBool(SP.showBackground, event.show);
    emit(state.copyWith(showBackGround: event.show));
  }

  // 切换背景显示事件处理 : 产出新状态
  void _onEventSwitchShowOver(
      EventSwitchShowOver event, Emitter<AppState> emit) async {
    emit(state.copyWith(showPerformanceOverlay: event.show));
  }

  // 切换code样式事件处理 : 固化索引 + 产出新状态
  void _onEventSwitchCoderTheme(
      EventSwitchCoderTheme event, Emitter<AppState> emit) async {
    (await sp).setInt(SP.codeStyleIndex, event.codeStyleIndex);
    emit(state.copyWith(codeStyleIndex: event.codeStyleIndex));
  }

  // 切换item样式事件处理 : 固化索引 + 产出新状态
  void _onEventChangeItemStyle(
      EventChangeItemStyle event, Emitter<AppState> emit) async {
    (await sp).setInt(SP.itemStyleIndex, event.index);
    emit(state.copyWith(itemStyleIndex: event.index));
  }

  void _onEventChangeAppStyle(EventChangeAppStyle event, Emitter<AppState> emit) async{
    (await sp).setInt(SP.appStyleIndex, event.style.index);
    emit(state.copyWith(appStyle: event.style));

  }

  void _onEventSwitchShowTool(EventSwitchShowTool event, Emitter<AppState> emit) async{
    (await sp).setBool(SP.showTool, event.show);
    emit(state.copyWith(showOverlayTool: event.show));
  }
}
