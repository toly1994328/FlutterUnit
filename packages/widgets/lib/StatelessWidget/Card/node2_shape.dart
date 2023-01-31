

/// create by 张风捷特烈 on 2020/4/25
/// contact me by email 1981462002@qq.com
/// 说明: 
//    {
//      "widgetId": 3,
//      "priority": 2,
//      "name": "可以通过shape属性实现裁切效果",
//      "subtitle": "【shape】 : 形状  【ShapeBorder】\n"
//          "【margin】: 外边距   【double】\n"
//          "【color】: 颜色   【Color】\n"
//          "【child】: 孩子   【Widget】",
//    }

import 'package:flutter/material.dart';
import 'package:widgets/utils/pather.dart';

class ShapeCard extends StatelessWidget {
  const ShapeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffB3FE65),
      elevation: 6,
      shape: StarShapeBorder(),
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 100,
        child: const Text("Card", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}

class StarShapeBorder extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      Pather.create.nStarPath(9, 50, 40, dx: 50, dy: 50);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
  }

  @override
  ShapeBorder scale(double t) {
    return this;
  }
}