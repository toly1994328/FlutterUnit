import 'dart:math';

import 'package:flutter/material.dart';

class UnDeuxTrois extends StatefulWidget {
  const UnDeuxTrois({Key? key}) : super(key: key);

  @override
  _UnDeuxTroisState createState() => _UnDeuxTroisState();
}

class _UnDeuxTroisState extends State<UnDeuxTrois> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {

        });
      },
      child: CustomPaint(
        painter: UnDeuxTroisPainter(),
      ),
    );
  }
}

class UnDeuxTroisPainter extends CustomPainter {
  void _draw(
    double x,
    double y,
    double width,
    double height,
    List positions,
    Canvas canvas,
  ) {
    canvas.save();
    canvas.translate(x + width / 2, y + height / 2);
    canvas.rotate(Random().nextDouble() * 5);
    canvas.translate(-width / 2, -height / 2);

    Paint paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < positions.length; i++) {
      Offset p1 = Offset(positions[i] * width, 0);
      Offset p2 = Offset(positions[i] * width, height);
      canvas.drawLine(p1, p2, paint);
    }
    canvas.restore();
  }

  @override
  void paint(Canvas canvas, Size size) {
    double height = size.height;
    double width = size.width;
    double step = 30;
    double aThirdOfHeight = size.height / 3;

    for (double y = step; y < height - step; y += step) {
      for (double x = step; x < width - step; x += step) {
        if (y < aThirdOfHeight) {
          _draw(x, y, step, step, [0.5], canvas);
        } else if (y < aThirdOfHeight * 2) {
          _draw(x, y, step, step, [0.2, 0.8], canvas);
        } else {
          _draw(x, y, step, step, [0.1, 0.5, 0.9], canvas);
        }
      }
    }
  }

  @override
  bool shouldRepaint(UnDeuxTroisPainter oldDelegate) => true;

}
