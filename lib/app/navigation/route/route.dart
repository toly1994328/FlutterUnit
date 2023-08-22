import 'dart:io';

import 'package:app/app.dart';
import 'package:flutter/material.dart';

import '../../views/setting/code_style_setting.dart';
import '../../views/setting/font_setting.dart';
import '../../views/setting/setting_page.dart';
import '../../views/setting/theme_color_setting.dart';
import '../unit_navigation.dart';

class RoutePath {

  static const String nav = 'nav';

  static const String themeColorSetting = 'ThemeColorSettingPage';
  static const String codeStyleSetting = 'CodeStyleSettingPage';
  static const String itemStyleSetting = 'ItemStyleSettingPage';
  static const String fontSetting = 'FountSettingPage';

  Map<String, WidgetBuilder> get routes =>
      {
        themeColorSetting: (ctx) => const ThemeColorSettingPage(),
        codeStyleSetting: (ctx) => const CodeStyleSettingPage(),
        fontSetting: (ctx) => const FontSettingPage(),
      };


  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case nav:
        if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
          return ZeroPageRoute(child: UnitNavigation());
        }
        return SlidePageRoute(child: UnitNavigation());
    }

    return null;
  }

}