import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:


//    {
//      "widgetId": 2,
//      "priority": 2,
//      "name": "文字阴影",
//      "subtitle": "【shadows】 : 文字  【List<Shadow>】\n"
//          "【backgroundColor】: 背景颜色   【Color】",
//    }
class ShadowText extends StatelessWidget {
  const ShadowText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "张风捷特烈",
      style: TextStyle(
          fontSize: 50,
          color: Colors.white,
          backgroundColor: Colors.black,
          shadows: [
            Shadow(
                color: Colors.cyanAccent,
                offset: Offset(1, 1),
                blurRadius: 10),
            Shadow(
                color: Colors.blue,
                offset: Offset(-0.1, 0.1),
                blurRadius: 10),
          ]),
    );
  }
}