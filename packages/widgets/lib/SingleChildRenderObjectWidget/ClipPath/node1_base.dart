import 'dart:math';

import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-04-19
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 69,
//      "name": 'ClipPath基本使用',
//      "priority": 1,
//      "subtitle": "【child】 : 子组件   【Widget】\n"
//          "【clipBehavior】 : 裁剪行为   【Clip】\n"
//          "【clipper】 : 裁剪器   【CustomClipper<Path>】",
//    }
class CustomClipPath extends StatelessWidget {
  const CustomClipPath({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ShapeBorderClipper(shape: _StarShapeBorder()),
      child: Image.asset(
        "assets/images/wy_300x200.webp",
        width: 150,
        height: 100,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _StarShapeBorder extends ShapeBorder {
  final Path _path = Path();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      nStarPath(20, rect.height / 2, rect.height / 2 * 0.85,
          dx: rect.width / 2, dy: rect.height / 2);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  Path nStarPath(int num, double R, double r, {dx = 0, dy = 0}) {
    double perRad = 2 * pi / num;
    double radA = perRad / 2 / 2;
    double radB = 2 * pi / (num - 1) / 2 - radA / 2 + radA;
    _path.moveTo(cos(radA) * R + dx, -sin(radA) * R + dy);
    for (int i = 0; i < num; i++) {
      _path.lineTo(
          cos(radA + perRad * i) * R + dx, -sin(radA + perRad * i) * R + dy);
      _path.lineTo(
          cos(radB + perRad * i) * r + dx, -sin(radB + perRad * i) * r + dy);
    }
    _path.close();
    return _path;
  }

  @override
  ShapeBorder scale(double t) {
    return this;
  }
}
