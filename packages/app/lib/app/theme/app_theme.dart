import 'dart:convert';
import 'dart:io';

import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app_config/bloc/state.dart';
import '../style/transition/fade_page_transitions_builder.dart';
import '../style/transition/slide_transition/slide_page_transition_builder.dart';

class AppTheme {
  static ThemeData darkTheme(AppConfigState state) {
    Color scaffoldBackgroundColor = const Color(0xff010201);

    SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    );
    bool useMaterial3 = (Platform.isAndroid || Platform.isIOS);

    return ThemeData(
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: SlidePageTransitionsBuilder(),
        TargetPlatform.iOS: SlidePageTransitionsBuilder(),
        TargetPlatform.macOS: FadePageTransitionsBuilder(),
        TargetPlatform.windows: FadePageTransitionsBuilder(),
        TargetPlatform.linux: FadePageTransitionsBuilder(),
      }),
      tabBarTheme: TabBarTheme(
        dividerColor:  Colors.transparent,
      ),
      fontFamily: state.fontFamily,
        useMaterial3:true,
      brightness: Brightness.dark,
      primaryColor: const Color(0xff4699FB),
        listTileTheme: ListTileThemeData(
          tileColor: Color(0xff181818),
          textColor: Color(0xffD6D6D6),
        ),
      appBarTheme:  AppBarTheme(
    systemOverlayStyle: overlayStyle,
    elevation: 0,
    centerTitle: true,
    backgroundColor: Color(0xff181818),

    iconTheme: IconThemeData(color:  Color(0xffCCCCCC)),

    titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Color(0xffCCCCCC))),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.white, backgroundColor: Color(0xff4699FB)),
        dividerTheme: DividerThemeData(
          color: const Color(0xff2F2F2F),
          space: px1,
          thickness: px1,
        ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xff181818),
          selectedItemColor: Color(0xff4699FB)),
    );
  }

  static ThemeData lightTheme(AppConfigState state) {
    SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    );

    return ThemeData(
      fontFamily: state.fontFamily,
      primaryColor: state.themeColor.color,
      scaffoldBackgroundColor: Color(0xffF3F4F6),
      useMaterial3: true,
      // Android 使用 Material3
      chipTheme: ChipThemeData(padding: EdgeInsets.symmetric(horizontal: 10)),
      listTileTheme: ListTileThemeData(
        tileColor: Colors.white,
      ),
      dividerTheme: DividerThemeData(
        color: const Color(0xffDEE0E2),
        space: px1,
        thickness: px1,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: SlidePageTransitionsBuilder(),
        TargetPlatform.iOS: SlidePageTransitionsBuilder(),
        TargetPlatform.macOS: FadePageTransitionsBuilder(),
        TargetPlatform.windows: FadePageTransitionsBuilder(),
        TargetPlatform.linux: FadePageTransitionsBuilder(),
      }),
      tabBarTheme: TabBarTheme(
        dividerColor:  Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            return states.contains(MaterialState.focused) ? null : Colors.transparent;
          },
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white),
      appBarTheme: AppBarTheme(
          systemOverlayStyle: overlayStyle,
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.black),
      ),
    );
  }
}
