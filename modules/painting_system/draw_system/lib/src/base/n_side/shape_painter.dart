import 'dart:math';

import 'package:dash_painter/dash_painter.dart';
import 'package:flutter/material.dart';

class ShapePainter extends CustomPainter {
  final int n;

  ShapePainter(this.n);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    int count = n;
    double radius = 140 / 2;
    drawAxis(canvas, size);
    List<Offset> points = [];
    double rotate = -pi / 2;
    for (int i = 0; i < count; i++) {
      double perRad = 2 * pi / count * i;
      points.add(Offset(
        radius * cos(perRad + rotate),
        radius * sin(perRad + rotate),
      ));
    }
    _drawShape(canvas, points);
    _drawShapeHelper(canvas, points, radius);
  }

  final Paint shapePaint = Paint()..style = PaintingStyle.stroke..color=Colors.blue..strokeWidth=2;

  void _drawShape(Canvas canvas, List<Offset> points) {
    Path shapePath = Path();
    shapePath.moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      shapePath.lineTo(points[i].dx, points[i].dy);
    }
    shapePath.close();
    canvas.drawPath(shapePath, shapePaint);
  }

  void _drawShapeHelper(Canvas canvas, List<Offset> points, double radius) {
    Path helpPath = Path()
      ..addOval(Rect.fromCenter(
          center: Offset.zero, width: radius * 2, height: radius * 2));
    dashPainter.paint(canvas, helpPath, helpPaint);
    for (Offset point in points) {
      drawAnchor(canvas, point);
    }
  }

  final Paint pointPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  void drawAnchor(Canvas canvas, Offset offset) {
    canvas.drawCircle(offset, 4, pointPaint..style = PaintingStyle.stroke);
    canvas.drawCircle(offset, 2, pointPaint..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant ShapePainter oldDelegate) {
    return oldDelegate.n != n;
  }

  final Paint helpPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.grey
    ..strokeWidth = 1;

  final DashPainter dashPainter = const DashPainter(span: 4, step: 4);

  Paint axisPaint = Paint()..color = Colors.black;

  void drawAxis(Canvas canvas, Size size) {
    axisPaint.style = PaintingStyle.stroke;
    Path helpPath = Path()
      ..moveTo(-size.width / 2, 0)
      ..relativeLineTo(size.width, 0)
      ..moveTo(0, -size.height / 2)
      ..relativeLineTo(0, size.height);
    dashPainter.paint(canvas, helpPath, axisPaint);

    axisPaint.style = PaintingStyle.fill;
    Path arrowXPath = Path();
    arrowXPath.moveTo(size.width / 2, 0);
    arrowXPath.relativeLineTo(-8, 4);
    arrowXPath.relativeLineTo(0, -8);
    arrowXPath.close();
    canvas.drawPath(arrowXPath, axisPaint);

    Path arrowYPath = Path();
    arrowYPath.moveTo(0, size.height / 2);
    arrowYPath.relativeLineTo(4, -8);
    arrowYPath.relativeLineTo(-8, 0);
    arrowYPath.close();
    canvas.drawPath(arrowYPath, axisPaint);

    drawHelpText("x", canvas, Offset(size.width / 2 - 8, 2));
    drawHelpText("y", canvas, Offset(6, size.height / 2 - 15));
  }

  final TextPainter textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );

  void drawHelpText(
    String text,
    Canvas canvas,
    Offset offset, {
    Color color = Colors.black,
  }) {
    textPainter.text = TextSpan(
      text: text,
      style: TextStyle(fontSize: 11, color: color,fontWeight: FontWeight.bold),
    );
    textPainter.layout(maxWidth: 200);
    textPainter.paint(canvas, offset);
  }
}
