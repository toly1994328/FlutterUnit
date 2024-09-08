import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:


//    {
//      "widgetId": 2,
//      "priority": 3,
//      "name": "文字装饰线",
//      "subtitle": "【fontFamily】 : 文字字体  【String】\n"
//          "【decoration】: 装饰线   【TextDecoration】\n"
//          "【decorationColor】: 装饰线颜色   【Color】\n"
//          "【decorationThickness】: 装饰线粗   【double】\n"
//          "【decorationStyle】: 装饰线样式   【TextDecorationStyle】",
//    }
class DecorationText extends StatelessWidget {
  const DecorationText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "19940328",
      style: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
          decorationThickness: 3,
          decorationStyle: TextDecorationStyle.wavy,
          decorationColor: Colors.blue,
          fontStyle: FontStyle.italic,
          fontFamily: "DancingScript",
          letterSpacing: 10),
    );
  }
}