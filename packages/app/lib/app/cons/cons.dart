
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:widget_module/widget_module.dart';

import '../res/toly_icon.dart';


class Cons {

  static const menuInfo = <String>["关于", "帮助", "问题反馈"]; //菜单栏

  static const List<Color> tabColors = [
    Color(0xff44D1FD),
    Color(0xffFD4F43),
    Color(0xffB375FF),
    Color(0xFF4CAF50),
    Color(0xFFFF9800),
    Color(0xFF00F1F1),
    Color(0xFFDBD83F),
  ];

  static const tabs = <String>[
    'Stles',
    'Stful',
    'Scrow',
    'Mcrow',
    'Sliver',
    'Proxy',
    'Other'
  ]; //标题列表

  static const iconMap = {
    //底栏图标
    "组件集录": TolyIcon.icon_layout, "收藏集录": TolyIcon.icon_star,
    "绘制集录": Icons.palette, "布局集录": Icons.widgets,
    "要点集录": TolyIcon.icon_bug,
  };

  static const List<String> kFontFamilySupport = [
    'local',
    'ComicNeue',
    'IndieFlower',
    'BalooBhai2',
    'Inconsolata',
    'Neucha'
  ];

  static const Map<WidgetFamily,String> kWidgetFamilyLabelMap = {
    WidgetFamily.statelessWidget: "Stateless",
    WidgetFamily.statefulWidget: "Stateful",
    WidgetFamily.singleChildRenderObjectWidget: "SingleChild",
    WidgetFamily.multiChildRenderObjectWidget: "MultiChild",
    WidgetFamily.sliver: "Sliver",
    WidgetFamily.proxyWidget: "Proxy",
    WidgetFamily.other: "Other",
  };

  static Map<HighlighterStyle, String> codeThemeSupport = <HighlighterStyle, String>{
    HighlighterStyle.fromColors(HighlighterStyle.gitHub):"GitHub - Power By 张风捷特烈",
    HighlighterStyle.fromColors(HighlighterStyle.darkColor):"捷特黑 - Power By 张风捷特烈",
    HighlighterStyle.fromColors(HighlighterStyle.lightColor):"捷特白 - Power By 张风捷特烈",
    HighlighterStyle.fromColors(HighlighterStyle.zenburn):"zenburn - Power By 张风捷特烈",
    HighlighterStyle.fromColors(HighlighterStyle.mf):"mf - Power By MF",
    HighlighterStyle.fromColors(HighlighterStyle.solarized):"cst - Power By cst",
  };


  // static final kThemeColorSupport = <MaterialColor, String>{
  //   Colors.red: "毁灭之红",
  //   Colors.orange: "愤怒之橙",
  //   Colors.yellow: "警告之黄",
  //   Colors.green: "伪装之绿",
  //   Colors.blue: "冷漠之蓝",
  //   Colors.indigo: "无限之靛",
  //   Colors.purple: "神秘之紫",
  //
  //   const MaterialColor(0xff2D2D2D, <int, Color>{
  //     50: Color(0xFF8A8A8A),
  //     100: Color(0xFF747474),
  //     200: Color(0xFF616161),
  //     300: Color(0xFF484848),
  //     400: Color(0xFF3D3D3D),
  //     500: Color(0xff2D2D2D),
  //     600: Color(0xFF252525),
  //     700: Color(0xFF141414),
  //     800: Color(0xFF050505),
  //     900: Color(0xff000000),
  //   }): "归宿之黑"
  // };

}

enum ThemeColor {
  red(Colors.red),
  orange(Colors.orange),
  yellow(Colors.yellow),
  green(Colors.green),
  blue(Colors.blue),
  indigo(Colors.indigo),
  purple(Colors.purple),
  dark(MaterialColor(0xff2D2D2D, <int, Color>{
    50: Color(0xFF8A8A8A),
    100: Color(0xFF747474),
    200: Color(0xFF616161),
    300: Color(0xFF484848),
    400: Color(0xFF3D3D3D),
    500: Color(0xff2D2D2D),
    600: Color(0xFF252525),
    700: Color(0xFF141414),
    800: Color(0xFF050505),
    900: Color(0xff000000),
  }));

  final MaterialColor color;

  const ThemeColor(this.color);

  String label(BuildContext context){
    return switch(this){
      ThemeColor.red => context.l10n.destructionRed,
      ThemeColor.orange => context.l10n.rageOrange,
      ThemeColor.yellow => context.l10n.warningYellow,
      ThemeColor.green => context.l10n.camouflageGreen,
      ThemeColor.blue => context.l10n.coldBlue,
      ThemeColor.indigo => context.l10n.infiniteBlue,
      ThemeColor.purple => context.l10n.mysteryPurple,
      ThemeColor.dark => context.l10n.destinyBlack,
    };
  }

}
