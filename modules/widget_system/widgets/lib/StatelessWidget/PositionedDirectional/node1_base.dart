import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-22
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 159,
//      "name": 'PositionedDirectional基本使用',
//      "priority": 1,
//      "subtitle": "【child】 : 组件   【Widget】\n"
//          "【top】 : 到父顶距离   【double】\n"
//          "【end】 : 到父右距离   【double】\n"
//          "【start】 : 到父左距离   【double】\n"
//          "【bottom】 : 到父底距离   【double】",
//    }
class CustomPositionedDirectional extends StatelessWidget {
  const CustomPositionedDirectional({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget yellowBox = Container(
      color: Colors.yellow,
      height: 100,
      width: 100,
    );

    Widget redBox = Container(
      color: Colors.red,
      height: 90,
      width: 90,
    );

    Widget greenBox = Container(
      color: Colors.green,
      height: 80,
      width: 80,
    );

    Widget cyanBox = Container(
      color: Colors.cyanAccent,
      height: 70,
      width: 70,
    );

    return Container(
        width: 200,
        height: 120,
        color: Colors.grey.withAlpha(33),
        child: Stack(
          children: <Widget>[
            yellowBox,
            redBox,
            PositionedDirectional(top: 20, start: 20, child: greenBox),
            PositionedDirectional(
              child: cyanBox,
              bottom: 10,
              end: 10,
            )
          ],
        ));
  }
}
