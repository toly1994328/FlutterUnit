import 'package:flutter/material.dart';

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

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Color> dataColor = [
      Colors.red, Colors.yellow,
      Colors.blue, Colors.green];
    List<double> dataThickness = [1.0, 2.0, 4.0, 6.0];
    Map<Color,double> data = Map.fromIterables(dataColor, dataThickness);
    return Column(
      children: dataColor
          .map((e) => Divider(
        color: e,
        thickness: data[e],
      )).toList(),
    );
  }
}