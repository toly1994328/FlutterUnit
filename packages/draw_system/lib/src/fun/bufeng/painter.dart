import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'config.dart';

class PiPainter extends CustomPainter {
  final Config config;

  PiPainter(this.config) : super(repaint: config);

  @override
  void paint(Canvas canvas, Size size) {
    print(size);
    Paint paint = Paint();
    paint.style = PaintingStyle.stroke;
    final double span = config.gap;
    drawHelpText(
      '$config',
      canvas,
      Offset.zero,
    );
    canvas.translate(0, size.height*0.3);

    canvas.save();
    for (int i = 0; i <= config.lineCount; i++) {
      canvas.drawLine(Offset.zero, Offset(size.width, 0), paint);
      print(span*i);
      canvas.translate(0, span);
    }
    canvas.restore();

    Paint needlePaint = Paint();
    needlePaint.style = PaintingStyle.stroke;
    needlePaint.strokeWidth = 1;

    for (Line line in config.lines) {
      if (line.isActive(config.gap)) {
        needlePaint.color = Colors.red;
      } else {
        needlePaint.color = Colors.green;
      }
      canvas.drawLine(line.p0, line.p1, needlePaint);
    }


  }

  @override
  bool shouldRepaint(covariant PiPainter oldDelegate) {
    return config != oldDelegate.config;
  }

  final TextPainter textPainter = TextPainter(
    textAlign: TextAlign.start,
    textDirection: TextDirection.ltr,
  );

  void drawHelpText(
    String text,
    Canvas canvas,
    Offset offset, {
    Color color = Colors.lightBlue,
  }) {
    textPainter.text = TextSpan(
      text: text,
      style: TextStyle(fontSize: 14, color: color),
    );
    textPainter.layout(maxWidth: 250);
    textPainter.paint(canvas, offset);
  }
}
