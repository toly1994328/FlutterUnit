import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:fx_boot_starter/fx_boot_starter.dart';

import '../structure/wrapper/bloc_wrapper.dart';
import '../structure/flutter_unit.dart';
import 'logic/app_start_action.dart';
import 'logic/app_start_repository.dart';

export 'view/splash/Flutter_unit_splash.dart';
export 'view/error/app_start_error.dart';

void bootStart(List<String> args) {
  runApp(
    AppStartScope<AppConfigState>(
      repository: const AppStartRepositoryImpl(),
      appStartAction: const AppStartActionImpl(),
      child: BlocWrapper(child: FlutterUnit3()),
    ),
  );
}
