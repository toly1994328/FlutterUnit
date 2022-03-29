import 'dart:math';

import 'package:dash_painter/dash_painter.dart';
import 'package:flutter/material.dart';

import 'line.dart';

class AnglePainter extends CustomPainter {
  final DashPainter dashPainter = const DashPainter(span: 4, step: 4);

  AnglePainter({required this.line}) : super(repaint: line);

  final Paint pointPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  final Paint helpPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.lightBlue
    ..strokeWidth = 1;

  final TextPainter textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );

  final Line line;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    drawHelp(canvas, size);
    line.paint(canvas);
  }

  void drawHelp(Canvas canvas, Size size) {
    Path helpPath = Path()
      ..moveTo(-size.width / 2, 0)
      ..relativeLineTo(size.width, 0)
      ..moveTo(0, -size.height / 2)
      ..relativeLineTo(0, size.height);
    dashPainter.paint(canvas, helpPath, helpPaint);

    drawHelpText('0°', canvas, Offset(size.width / 2 - 20, 0));
    drawHelpText('p0', canvas, line.start.translate(-20, 0));
    drawHelpText('p1', canvas, line.end.translate(-20, 0));

    // drawHelpText('p2', canvas, Offset(60, 40).translate(10, 0));
    // drawAnchor(canvas, Offset(60, 40));
    drawAnchor(canvas, line.percent(0.2));
    // drawAnchor(canvas, line.percent(0.5));

    // drawAnchor(canvas, line.percent(0.8));

    drawHelpText(
      '角度: ${(line.positiveRad * 180 / pi).toStringAsFixed(2)}°',
      canvas,
      Offset(
        -size.width / 2 + 10,
        -size.height / 2 + 10,
      ),
    );



    // canvas.drawArc(
    //   Rect.fromCenter(center: line.start, width: 20, height: 20),
    //   0,
    //   line.positiveRad,
    //   false,
    //   helpPaint,
    // );

    // canvas.save();
    // Offset center = const Offset(60, 60);
    // canvas.translate(center.dx, center.dy);
    // canvas.rotate(line.positiveRad);
    // canvas.translate(-center.dx, -center.dy);
    // canvas.drawCircle(center, 4, helpPaint);
    // canvas.drawRect(
    //     Rect.fromCenter(center: center, width: 30, height: 60), helpPaint);
    // canvas.restore();
  }

  void drawAnchor(Canvas canvas, Offset offset) {
    canvas.drawCircle(offset, 4, pointPaint..style = PaintingStyle.stroke);
    canvas.drawCircle(offset, 2, pointPaint..style = PaintingStyle.fill);
  }

  void drawHelpText(
    String text,
    Canvas canvas,
    Offset offset, {
    Color color = Colors.lightBlue,
  }) {
    textPainter.text = TextSpan(
      text: text,
      style: TextStyle(fontSize: 12, color: color),
    );
    textPainter.layout(maxWidth: 200);
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
