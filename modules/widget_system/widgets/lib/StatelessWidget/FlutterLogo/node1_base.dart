

/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 4,
//      "priority": 1,
//      "name": "用于显示一个FlutterLogo",
//      "subtitle": "【size】 : 大小  【double】\n"
//          "【colors】: 颜色   【MaterialColor】",
//    }
import 'package:flutter/material.dart';

class CustomFlutterLogo extends StatelessWidget {
  const CustomFlutterLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Map<Color,double> data = {
      Colors.blue:50.0,
      Colors.red:60.0,
      Colors.green:70.0,
      Colors.yellow:80.0,
    };
    return Wrap(
      children: data.keys
          .map((e) => FlutterLogo(
        size: data[e],
        textColor: e,
      )).toList(),
    );
  }
}