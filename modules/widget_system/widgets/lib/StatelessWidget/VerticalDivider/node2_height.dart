

import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/27
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 35,
//      "priority": 2,
//      "name": "VerticalDivider宽度和空缺",
//      "subtitle": "【indent】: 前面空缺长度   【double】\n"
//          "【endIndent】: 后面空缺长度   【double】\n"
//          "【width】: 占位宽   【double】",
//    }
class WidthVerticalDivider extends StatelessWidget {
  const WidthVerticalDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Color> dataColor = [
      Colors.red, Colors.yellow,
      Colors.blue, Colors.green];
    List<double> dataThickness = [10.0, 20.0, 30.0, 40.0];
    Map<Color,double>  data = Map.fromIterables(dataColor, dataThickness);
    return SizedBox(
      height: 150,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: dataColor
            .map((e) => VerticalDivider(
          color: e,
          indent:data[e],
          endIndent: data[e]!*2,
          width: data[e],
          thickness: data[e]!/10,
        ))
            .toList(),
      ),
    );
  }
}
