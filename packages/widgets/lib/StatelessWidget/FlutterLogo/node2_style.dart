import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 4,
//      "priority": 2,
//      "name": "样式用于显示文字",
//      "subtitle": "【style】 : 样式-3种枚举  【FlutterLogoStyle】\n"
//          "【textColor】: 文字颜色   【Color】",
//    }
class FlutterLogoWithText extends StatelessWidget {
  const FlutterLogoWithText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<FlutterLogoStyle, Color> data = {
      FlutterLogoStyle.horizontal: Colors.blue,
      FlutterLogoStyle.markOnly: Colors.red,
      FlutterLogoStyle.stacked: Colors.green,
    };

    return Wrap(
      spacing: 20,
      children: data.keys
          .map((FlutterLogoStyle style) => FlutterLogo(
                size: 80,
                style: style,
                textColor: data[style]!,
              ))
          .toList(),
    );
  }
}