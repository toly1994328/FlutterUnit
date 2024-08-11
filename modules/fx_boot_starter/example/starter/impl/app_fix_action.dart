import 'package:fx_boot_starter/fx_boot_starter.dart';
import 'package:flutter/material.dart';



class AppFixActionImpl implements AppFixAction {

  const AppFixActionImpl();

  @override
  void onFixSuccess(BuildContext context) {
    // TODO go fix success
  }

  @override
  void onFixError(BuildContext context, Object error, StackTrace trace) {

  }
}
