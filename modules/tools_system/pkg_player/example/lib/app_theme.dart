import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



ThemeData lightTheme() {
  SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent);

  double px1 = 1/window.devicePixelRatio;
  return ThemeData(
    scaffoldBackgroundColor: const Color(0xffF3F4F6),
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

    // Android 使用 Material3
    chipTheme:
        const ChipThemeData(padding: EdgeInsets.symmetric(horizontal: 10)),
    listTileTheme: const ListTileThemeData(
        tileColor: Colors.white, textColor: Color(0xff333333)),

    ///设置选中的文本颜色
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Colors.blue.withOpacity(0.3),
    ),
    dividerTheme: DividerThemeData(
      color: const Color(0xffDEE0E2),
      space: px1,
      thickness: px1,
    ),
    // pageTransitionsTheme: const PageTransitionsTheme(builders: {
    //   TargetPlatform.android: SlidePageTransitionsBuilder(),
    //   TargetPlatform.iOS: SlidePageTransitionsBuilder(),
    //   TargetPlatform.macOS: FadePageTransitionsBuilder(),
    //   TargetPlatform.windows: FadePageTransitionsBuilder(),
    //   TargetPlatform.linux: FadePageTransitionsBuilder(),
    // }),
    tabBarTheme: TabBarThemeData(
      dividerColor: Colors.transparent,
      // labelStyle: TextStyle(fontFamily: fontFamily),
      // unselectedLabelStyle: TextStyle(fontFamily: fontFamily),

      splashFactory: NoSplash.splashFactory,
      overlayColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          return states.contains(WidgetState.focused)
              ? null
              : Colors.transparent;
        },
      ),
    ),
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: Colors.white),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: overlayStyle,
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  );
}
