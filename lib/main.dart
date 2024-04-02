import 'package:app/app.dart';
import 'package:app_boot_starter/app_boot_starter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'app/bloc_wrapper.dart';
import 'app/flutter_unit.dart';
import 'app_stater/impl/app_start_action.dart';
import 'app_stater/impl/start_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //滚动性能优化 1.22.0
  GestureBinding.instance.resamplingEnabled = true;
  runApp(
    AppStartScope<AppConfigState>(
      repository: const AppStartRepositoryImpl(),
      appStartAction: const AppStartActionImpl(),
      child: BlocWrapper(child: FlutterUnit3()),
    ),
  );
  WindowsAdapter.setSize();
}
