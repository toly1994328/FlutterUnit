import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020/4/27
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 35,
//      "priority": 1,
//      "name": "VerticalDivider颜色和粗细",
//      "subtitle": "【color】: 颜色   【Color】\n"
//          "【thickness】: 线粗细   【double】",
//    }
class CustomVerticalDivider extends StatelessWidget {
  const CustomVerticalDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Color> dataColor = [
      Colors.red, Colors.yellow,
      Colors.blue, Colors.green];
    List<double> dataThickness = [1.0, 2.0, 4.0, 6.0];
    Map<Color,double> data = Map.fromIterables(dataColor, dataThickness);
    return SizedBox(
      height: 150,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: dataColor
            .map((e) => VerticalDivider(
          color: e,
          thickness: data[e],
        )).toList(),
      ),
    );
  }
}