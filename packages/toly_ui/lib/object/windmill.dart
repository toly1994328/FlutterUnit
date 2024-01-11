
import 'dart:math';

import 'package:flutter/material.dart';

class WindmillWidget extends StatelessWidget {
  final double rotate;
  final double radius;
  const WindmillWidget({Key? key, this.rotate=0,this.radius = 60}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        size:  Size(radius, radius),
        painter: WindmillPainter(rotate),
    );
  }
}

const List<Color> kColors =  [
  Color(0xffE74437),
  Color(0xffFBBD19),
  Color(0xff3482F0),
  Color(0xff30A04C)
];

class WindmillPainter extends CustomPainter {
  final double rotate;

  WindmillPainter(this.rotate);

  @override
  void paint(Canvas canvas, Size size) {

    canvas.translate(size.width / 2, size.height / 2);
    double d = size.width * 0.5;
    canvas.rotate(rotate);
    Paint paint = Paint();
    for (Color color in kColors) {
      Path path1 = Path()
        ..moveTo(0, -d * 46 / 203)
        ..lineTo(0, -d * 203 / 203)
        ..lineTo(102 / 203 * d, -102 / 203 * d)
        ..lineTo(12 / 203 * d, -12 / 203 * d)
        ..close();
      canvas.drawPath(path1, paint..color = color);

      Path path2 = Path()
        ..moveTo(12 / 203 * d, -12 / 203 * d)
        ..lineTo(102 / 203 * d, -102 / 203 * d)
        ..lineTo(102 / 203 * d, 0)
        ..lineTo(46 / 203 * d, 0)
        ..close();
      canvas.drawPath(path2, paint..color = color.withOpacity(0.2));
      canvas.rotate(pi / 2);
    }
  }


  @override
  bool shouldRepaint(covariant WindmillPainter oldDelegate) => oldDelegate.rotate!=rotate;
}