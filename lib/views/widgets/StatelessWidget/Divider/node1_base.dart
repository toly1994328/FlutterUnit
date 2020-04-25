
/// create by 张风捷特烈 on 2020-03-24
/// contact me by email 1981462002@qq.com
/// 说明:
///
//    {
//      "widgetId": 34,
//      "priority": 1,
//      "name": "Divider颜色和粗细",
//      "subtitle": "【color】: 颜色   【Color】\n"
//          "【thickness】: 线粗细   【double】",
//    }

import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dataColor = [
      Colors.red, Colors.yellow,
      Colors.blue, Colors.green];
    var dataThickness = [1.0, 2.0, 4.0, 6.0];
    var data = Map.fromIterables(dataColor, dataThickness);
    return Column(
      children: dataColor
          .map((e) => Divider(
        color: e,
        thickness: data[e],
      ))
          .toList(),
    );
  }
}