import 'package:flutter/material.dart';

//    {
//      "widgetId": 68,
//      "name": 'ClipRRect基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 子组件   【Widget】\n"
//          "【borderRadius】 : 边线半径   【BorderRadius】\n"
//          "【clipBehavior】 : 裁剪行为   【Clip】\n"
//          "【clipper】 : 裁剪器   【CustomClipper<Rect>】",
//    }
class CustomClipRRect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.elliptical(35, 30)),
      child: Image.asset(
        "assets/images/wy_300x200.jpg",
        width: 150,
        height: 100,
      ),
    );
  }
}
