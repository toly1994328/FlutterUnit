import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:


//    {
//      "widgetId": 2,
//      "priority": 1,
//      "name": "文字的基本样式",
//      "subtitle": "【入参】 : 文字  【String】\n"
//          "【style】: 文字样式   【TextStyle】\n"
//          "【color】: 文字样式   【Color】\n"
//          "【fontSize】: 文字大小   【double】\n"
//          "【fontWeight】: 字重   【FontWeight】\n"
//          "【fontStyle】: 字体样式   【fontStyle】\n"
//          "【letterSpacing】: 字距   【double】",
//    }
class CustomText extends StatelessWidget {
  const CustomText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle style = const TextStyle(
      color: Colors.blue,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      letterSpacing: 10,
    );
    return Container(
      width: 200,
      color: Colors.cyanAccent.withAlpha(33),
      height: 200 * 0.618 * 0.618,
      child: Text("toly-张风捷特烈-1994`", style: style),
    );
  }
}