import 'package:fx_boot_starter/fx_boot_starter.dart';
import 'package:flutter/material.dart';

import 'starter/data/app_state.dart';
import 'starter/impl/app_fix_action.dart';
import 'starter/impl/app_start_action.dart';
import 'starter/impl/start_repository.dart';
import 'starter/views/splash_page.dart';

void main() {
  runApp(
    const AppStartScope<AppState>(
      repository: AppStartRepositoryImpl(),
      appStartAction: AppStartActionImpl(),
      fixAction: AppFixActionImpl(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AppStartListener<AppState>(
          child: SplashPage(),
        ));
  }
}
