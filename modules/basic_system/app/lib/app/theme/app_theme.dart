import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkTheme(AppConfig state) {
  const Color scaffoldBackgroundColor = Color(0xff010201);

  SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xff181818));

  return ThemeData(
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: SlidePageTransitionsBuilder(),
      TargetPlatform.iOS: SlidePageTransitionsBuilder(),
      TargetPlatform.macOS: FadePageTransitionsBuilder(),
      TargetPlatform.windows: FadePageTransitionsBuilder(),
      TargetPlatform.linux: FadePageTransitionsBuilder(),
    }),
    tabBarTheme: const TabBarThemeData(
      dividerColor: Colors.transparent,
    ),
    fontFamily: state.fontFamily,
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: const Color(0xff4699FB),
    listTileTheme: const ListTileThemeData(
      tileColor: Color(0xff181818),
      textColor: Color(0xffD6D6D6),
    ),

    ///设置选中的文本颜色
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Colors.blue.withOpacity(0.3),
    ),
    appBarTheme: AppBarTheme(
        systemOverlayStyle: overlayStyle,
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xff181818),
        iconTheme: const IconThemeData(color: Color(0xffCCCCCC)),
        titleTextStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xffCCCCCC))),
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

ThemeData lightTheme(AppConfig state) {
  SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent);

  String fontFamily = state.fontFamily;
  if (kAppEnv.isWindows) {
    fontFamily = '宋体';
  }
  return ThemeData(
    fontFamily: fontFamily,
    primaryColor: state.themeColor.color,
    scaffoldBackgroundColor: const Color(0xffF3F4F6),
    useMaterial3: true,
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
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: SlidePageTransitionsBuilder(),
      TargetPlatform.iOS: SlidePageTransitionsBuilder(),
      TargetPlatform.macOS: FadePageTransitionsBuilder(),
      TargetPlatform.windows: FadePageTransitionsBuilder(),
      TargetPlatform.linux: FadePageTransitionsBuilder(),
    }),
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
        fontFamily: fontFamily,
      ),
    ),
  );
}
