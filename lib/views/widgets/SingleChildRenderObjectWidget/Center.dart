import 'dart:math';

import 'package:flutter/material.dart';

//    {
//      "widgetId": 86,
//      "name": 'Center基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子组件   【Widget】",
//    }
class CustomCenter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        width: 200,
        height: 100,
        color: Colors.grey.withAlpha(88),
        child: Center(
            child: Container(
          width: 80,
          height: 60,
          color: Colors.cyanAccent,
        )));
  }
}
