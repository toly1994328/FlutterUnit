import 'package:flutter/material.dart';

//    {
//      "widgetId": 67,
//      "name": 'ClipRect基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 子组件   【Widget】\n"
//          "【clipBehavior】 : 裁剪行为   【Clip】\n"
//          "【clipper】 : 裁剪器   【CustomClipper<Rect>】",
//    }
class CustomClipRect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SizedBox(
        height: 100,
        width: 100,
        child: Image.asset("assets/images/wy_300x200.jpg",fit: BoxFit.cover,),
      ),
    );
  }
}
