import 'dart:math';

import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-06
/// contact me by email 1981462002@qq.com
/// 说明:

class CouponShapeBorder extends ShapeBorder {
  final int holeCount;
  final double lineRate;
  final bool dash;
  final bool hasLine;
  final Color color;
  final bool hasTopHole;
  final bool hasBottomHole;
  final double edgeRadius;

  CouponShapeBorder(
      {this.holeCount = 6,
        this.hasTopHole =true,
        this.hasBottomHole =false,
      this.lineRate = 0.718,
      this.dash = true,
      this.hasLine = true,
      this.color = Colors.white,this.edgeRadius});

  @override
  EdgeInsetsGeometry get dimensions => null;

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return null;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    var w = rect.width;
    var h = rect.height;

    var d = h / (1 + 2 * holeCount);

    var path = Path();
    path.addRect(rect);

    _formHoldLeft(path, d);

    _formHoldRight(path, w, d);
    if (hasLine) {
      _formHoleTop(path, rect, d);
      _formHoleBottom(path, rect, d);
    }
    if(edgeRadius!=null){
      if(hasTopHole){
        _formHoleTop(path, rect, edgeRadius);
      }
      if(hasBottomHole){
        _formHoleBottom(path, rect, edgeRadius);
      }

    }
    path.fillType = PathFillType.evenOdd;

    return path;
  }

  void _formHoleBottom(Path path, Rect rect, double d) {
    path.addArc(
        Rect.fromCenter(
            center: Offset(lineRate * rect.width, rect.height),
            width: d,
            height: d),
        pi,
        pi);
  }

  void _formHoleTop(Path path, Rect rect, double d) {
    path.addArc(
        Rect.fromCenter(
            center: Offset(lineRate * rect.width, 0), width: d, height: d),
        0,
        pi);
  }

  _formHoldLeft(Path path, double d) {
    for (int i = 0; i < holeCount; i++) {
      var left = -d / 2;
      var top = 0.0 + d + 2 * d * (i);
      var right = left + d;
      var bottom = top + d;
      path.addArc(Rect.fromLTRB(left, top, right, bottom), -pi / 2, pi);
    }
  }

  _formHoldRight(Path path, double w, double d) {
    for (int i = 0; i < holeCount; i++) {
      var left = -d / 2 + w;
      var top = 0.0 + d + 2 * d * (i);
      var right = left + d;
      var bottom = top + d;
      path.addArc(Rect.fromLTRB(left, top, right, bottom), pi / 2, pi);
    }
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    if(!hasLine) return;
    var paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;
    var d = rect.height / (1 + 2 * holeCount);
    if (dash) {
      _drawDashLine(canvas, Offset(lineRate * rect.width, d / 2),
          rect.height / 16, rect.height - 13, paint);
    } else {
      canvas.drawLine(Offset(lineRate * rect.width, d / 2),
          Offset(lineRate * rect.width, rect.height - d / 2), paint);
    }
  }

  _drawDashLine(
      Canvas canvas, Offset start, double count, double length, Paint paint) {
    var step = length / count / 2;
    for (int i = 0; i < count; i++) {
      var offset = start + Offset(0, 2 * step * i);
      canvas.drawLine(offset, offset + Offset(0, step), paint);
    }
  }

  @override
  ShapeBorder scale(double t) {
    // TODO: implement scale
    return null;
  }
}
