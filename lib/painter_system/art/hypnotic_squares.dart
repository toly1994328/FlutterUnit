import 'dart:math';

import 'package:flutter/material.dart';

import '../utils/colors.dart';

class HypnoticSquares extends StatefulWidget {
  const HypnoticSquares({Key? key}) : super(key: key);

  @override
  _HypnoticSquaresState createState() => _HypnoticSquaresState();
}

class _HypnoticSquaresState extends State<HypnoticSquares> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {

        });
      },
      child: CustomPaint(
        painter: HypnoticSquaresPainter(),
      ),
    );
  }
}

class HypnoticSquaresPainter extends CustomPainter {
  double startSteps = 1;
  double offset = 4.0;
  double finalSize = 10.0;
  Random random = Random();
  List directions = [-1.0, 0.0, 1.0];

  void _drawRect(Canvas canvas, double x, double y, double size) {
    Paint paint = Paint()
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..color = colors[Random().nextInt(colors.length)];
    Rect rect = Rect.fromLTWH(x, y, size, size);

    canvas.drawRect(rect, paint);
  }

  void _draw(
    double x,
    double y,
    double size,
    double xMovement,
    double yMovement,
    double steps,
    Canvas canvas,
  ) {
    _drawRect(canvas, x, y, size);

    if (steps >= 0) {
      final newSize = size * (steps / startSteps) + finalSize;
      double newX = x + (size - newSize) / 2;
      double newY = y + (size - newSize) / 2;
      newX = newX - ((x - newX) / (steps + 2)) * xMovement;
      newY = newY - ((y - newY) / (steps + 2)) * yMovement;
      _draw(
        newX,
        newY,
        newSize,
        xMovement,
        yMovement,
        steps - 1,
        canvas,
      );
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    double canvasSize = size.width;
    double tileStep = (canvasSize - offset * 2) / 6;
    double startSize = tileStep;

    for (double x = offset; x < canvasSize - offset; x += tileStep) {
      for (double y = offset; y < canvasSize - offset; y += tileStep) {
        startSteps = 2.0 + random.nextInt(10);
        double xDirection = directions[random.nextInt(directions.length)];
        double yDirection = directions[random.nextInt(directions.length)];

        _draw(
          x,
          y,
          startSize,
          xDirection,
          yDirection,
          startSteps - 1,
          canvas,
        );
      }
    }
  }

  @override
  bool shouldRepaint(HypnoticSquaresPainter oldDelegate) => true;
}
