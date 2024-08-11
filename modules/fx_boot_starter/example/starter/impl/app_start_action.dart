import 'package:fx_boot_starter/fx_boot_starter.dart';
import 'package:flutter/material.dart';

import '../data/app_state.dart';



class AppStartActionImpl implements AppStartAction<AppState> {

  const AppStartActionImpl();

  @override
  void onLoaded(BuildContext context, int cost, AppState state) {
    debugPrint("App启动耗时:$cost ms");
  }

  @override
  void onStartError(BuildContext context, Object error, StackTrace trace) {
// TODO go start success
  }

  @override
  void onStartSuccess(BuildContext context,AppState state) {
// TODO go start success
  }
}
