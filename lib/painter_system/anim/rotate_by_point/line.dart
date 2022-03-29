import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Line with ChangeNotifier {
  Line({
    this.start = Offset.zero,
    this.end = Offset.zero,
  });

  Offset start;
  Offset end;

  final Paint pointPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  void paint(Canvas canvas) {
    canvas.drawLine(start, end, pointPaint);
    drawAnchor(canvas, start);
    drawAnchor(canvas, end);
  }

  double get rad => (end - start).direction;

  double get positiveRad => rad < 0 ? 2 * pi + rad : rad;

  double get length => (end - start).distance;

  void drawAnchor(Canvas canvas, Offset offset) {
    canvas.drawCircle(offset, 4, pointPaint..style = PaintingStyle.stroke);
    canvas.drawCircle(offset, 2, pointPaint..style = PaintingStyle.fill);
  }

  double detaRotate = 0;

  void rotate(double rotate, {Offset? centre}) {
    detaRotate = rotate - detaRotate;
    centre = centre ?? start;
    Line p2p0 = Line(start: centre, end: start);
    Line p2p1 = Line(start: centre, end: end);
    p2p0._rotateByStart(detaRotate);
    p2p1._rotateByStart(detaRotate);
    start = p2p0.end;
    end = p2p1.end;
    detaRotate = rotate;
    notifyListeners();
  }



  Offset percent(double percent){
    return Offset(
        length*percent*cos(rad),
        length*percent*sin(rad),
    )+start;
  }

  void _rotateByStart(double rotate) {
    end = Offset(
          length * cos(rad + rotate),
          length * sin(rad + rotate),
        ) +
        start;
  }

  void tick() {
    notifyListeners();
  }
}
