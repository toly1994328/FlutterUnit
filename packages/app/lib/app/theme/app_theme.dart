import 'dart:io';

import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static ThemeData darkTheme(AppState state) {
    Color scaffoldBackgroundColor = const Color(0xff010201);


    SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    );
    bool useMaterial3 = (Platform.isAndroid || Platform.isIOS);

    return ThemeData(
      scaffoldBackgroundColor: scaffoldBackgroundColor,

      tabBarTheme: TabBarTheme(
        dividerColor:  Colors.transparent,
      ),
      fontFamily: state.fontFamily,
        useMaterial3:useMaterial3,
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

  static ThemeData lightTheme(AppState state) {
    SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    );

    bool useMaterial3 = (Platform.isAndroid || Platform.isIOS);

    return ThemeData(
      fontFamily: state.fontFamily,
      primaryColor: state.themeColor,
      scaffoldBackgroundColor: Color(0xffF3F4F6),
      useMaterial3: useMaterial3,
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
