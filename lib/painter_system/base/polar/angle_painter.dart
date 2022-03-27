import 'dart:math';

import 'package:dash_painter/dash_painter.dart';
import 'package:flutter/material.dart';

import 'polar.dart';

class PolarPainter extends CustomPainter {
  final DashPainter dashPainter = const DashPainter(span: 4, step: 4);

  final Paint helpPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.grey
    ..strokeWidth = 1;

  Polar2D p1 = Polar2D(pi / 4, 75);

  final TextPainter textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );


  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color=Colors.blue;
    canvas.translate(size.width / 2, size.height / 2);
    drawHelp(canvas, size);
    collect().forEach((Polar2D point) {
      canvas.drawCircle(point.offset, 1, paint);
    });
  }

  List<Polar2D> collect() {
    List<Polar2D> points = [];
    for (int i = 0; i < 360; i++) {
      double rad = i * pi / 180;
      double length = 100 * cos(4 * rad);
      points.add(Polar2D(rad, length));
    }
    return points;
  }

  void drawHelp(Canvas canvas, Size size) {
    Path helpPath = Path()
      ..moveTo(-size.width / 2, 0)
      ..relativeLineTo(size.width, 0)
      ..moveTo(0, -size.height / 2)
      ..relativeLineTo(0, size.height);

    for (int i = 0; i < 5; i++) {
      helpPath.addOval(Rect.fromCenter(center: Offset.zero, width: 50.0 * i, height: 50.0 * i));
      drawHelpText('${25 * i}', canvas, Offset(25.0 * i - 10, 0));
    }

    dashPainter.paint(canvas, helpPath, helpPaint);

    drawHelpText('90°', canvas, Offset(0 - 8, size.height*0.85 / 2),
        color: Colors.black);
    drawHelpText('180°', canvas, Offset(-size.width*0.8 / 2 - 30, 0 - 8),
        color: Colors.black);
    drawHelpText('270°', canvas, Offset(0 - 8, -size.height*0.85 / 2 - 16),
        color: Colors.black);
    drawHelpText('0°', canvas, Offset(size.width*0.85 / 2 + 10, 0 - 8),
        color: Colors.black);
  }

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

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
