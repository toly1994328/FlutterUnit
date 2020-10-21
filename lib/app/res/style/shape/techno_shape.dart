import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-06
/// contact me by email 1981462002@qq.com
/// 说明: 打个洞
/// offset 洞的偏移量分率 x,y 在 0~1 之间
/// size 洞的大小

class TechnoShapeBorder extends ShapeBorder {
  final Path outLinePath = Path();
  final Paint _paint = Paint();
  final Path innerLinePath = Path();
  final Path innerLinePathTop = Path();
  final Color color;

  final cornerWidth;

  final spanWidth;
  final storkWidth;
  final innerRate;

  TechnoShapeBorder(
      {this.color = Colors.green,
      this.cornerWidth = 10.0,
      this.spanWidth = 2.5,
      this.innerRate = 0.15,
      this.storkWidth = 1.0}) {
    _paint
      ..color = color
      ..strokeWidth = storkWidth;
  }

  @override
  EdgeInsetsGeometry get dimensions => null;

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    Path path = Path();
    path.addRRect(RRect.fromRectAndRadius(rect, Radius.circular(5)));
    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    outLinePath
      ..moveTo(cornerWidth, 0)
      ..lineTo(rect.width - cornerWidth, 0)
      ..lineTo(rect.width, cornerWidth)
      ..lineTo(rect.width, rect.height - cornerWidth)
      ..lineTo(rect.width - cornerWidth, rect.height)
      ..lineTo(cornerWidth, rect.height)
      ..lineTo(0, rect.height - cornerWidth)
      ..lineTo(0, cornerWidth)
      ..close();
    innerLinePath
      ..moveTo(rect.width / 2, rect.height)
      ..relativeLineTo(rect.width * innerRate, 0)
      ..relativeLineTo(-spanWidth * 2, -spanWidth)
      ..relativeLineTo(-rect.width * innerRate * 2, 0)
      ..relativeLineTo(-spanWidth * 2, spanWidth)
      ..close();
    return Path.combine(PathOperation.difference, outLinePath, innerLinePath);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    canvas.drawPath(
        Path.combine(PathOperation.difference, outLinePath, innerLinePath),
        _paint..style = PaintingStyle.stroke);

    innerLinePathTop
      ..moveTo(rect.width / 2, 0)
      ..relativeLineTo(rect.width * innerRate, 0)
      ..relativeLineTo(-spanWidth * 2, spanWidth)
      ..relativeLineTo(-rect.width * innerRate * 2, 0)
      ..relativeLineTo(-spanWidth * 2, -spanWidth)
      ..close();
    canvas.drawPath(innerLinePathTop, _paint..style = PaintingStyle.fill);
  }

  @override
  ShapeBorder scale(double t) {
    // TODO: implement scale
    return null;
  }
}
