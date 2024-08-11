import 'package:app/app.dart';
import 'package:fx_boot_starter/fx_boot_starter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'app/bloc_wrapper.dart';
import 'app/flutter_unit.dart';
import 'app_stater/impl/app_start_action.dart';
import 'app_stater/impl/start_repository.dart';

void main() {
  runApp(
    AppStartScope<AppConfigState>(
      repository: const AppStartRepositoryImpl(),
      appStartAction: const AppStartActionImpl(),
      child: BlocWrapper(child: FlutterUnit3()),
    ),
  );
}
