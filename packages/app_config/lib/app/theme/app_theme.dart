import 'dart:io';

import 'package:app_config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static ThemeData darkTheme(AppState state) => ThemeData(
      fontFamily: state.fontFamily,
      brightness: Brightness.dark,
      primaryColor: const Color(0xff4699FB),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xff222222)),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.white, backgroundColor: Color(0xff4699FB)),
      dividerColor: Colors.white,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xff181818),
          selectedItemColor: Color(0xff4699FB)),
      scaffoldBackgroundColor: const Color(0xff010201));

  static ThemeData lightTheme(AppState state) {
    SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark);

    bool useMaterial3 = (Platform.isAndroid || Platform.isIOS)&&state.appStyle!=AppStyle.fancy;

    return ThemeData(
      fontFamily: state.fontFamily,
      primaryColor: state.themeColor,
      useMaterial3: useMaterial3 ,
      // Android 使用 Material3
      chipTheme: ChipThemeData(padding: EdgeInsets.symmetric(horizontal: 10)
          ),
      dividerTheme: DividerThemeData(
        color: const Color(0xffDEE0E2),
        space: px1,
        thickness: px1,
      ),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: overlayStyle,
      ),
    );
  }
}
