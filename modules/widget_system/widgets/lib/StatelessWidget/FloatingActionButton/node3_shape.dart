

/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 28,
//      "priority": 3,
//      "name": "shape属性",
//      "subtitle": "【shape】: 形状   【ShapeBorder】",
//    }

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:widgets/utils/pather.dart';

class ShapeFAB extends StatelessWidget {
  const ShapeFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<Color,IconData> data = {
      Colors.red: Icons.add,
      Colors.blue: Icons.bluetooth,
      Colors.green: Icons.android,
    };
    return Wrap(
        spacing: 20,
        children: data.keys
            .map((e) => FloatingActionButton(
          heroTag:  e.toString()+"c",
          onPressed: () {},
          backgroundColor: e,
          shape: StarBorder(),
          foregroundColor: Colors.white,
          child: Icon(data[e]),
          tooltip: "android",
          elevation: 5,
        )).toList());
  }
}

/// 边线形状类
class StarBorder extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Pather.create.nStarPath(20, 25, 25 * cos((360 / 9 / 2) * pi / 180),
        dx: rect.height / 2, dy: rect.width / 2);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}