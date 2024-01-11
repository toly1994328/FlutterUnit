import 'dart:math';

import 'package:flutter/material.dart';
import '../utils/colors.dart';

class Circle {
  Point center = const Point(0,0);
  double radius = 10;
  Color color = Colors.black;
}

class CirclePacking extends StatefulWidget {
  const CirclePacking({Key? key}) : super(key: key);

  @override
  _CirclePackingState createState() => _CirclePackingState();
}

class _CirclePackingState extends State<CirclePacking> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {

        });
      },
      child: CustomPaint(
        painter: CirclePackingPainter(),
      ),
    );
  }
}

class CirclePackingPainter extends CustomPainter {
  List<Circle> circles = [];
  double minRaidus = 2;
  double maxRaidus = 100;
  int totalCircles = 500;
  int createCircleAttemps = 500;
  Random random = Random();

  void _createCircles(Canvas canvas, Size size) {
    Circle circle= Circle();

    bool circleSafeToDraw = false;

    for (int i = 0; i < createCircleAttemps; i++) {
      circle
        ..radius = minRaidus
        ..center = Point(
          random.nextDouble() * size.width,
          random.nextDouble() * size.height,
        )
        ..color = colors[Random().nextInt(colors.length)];

      if (_doesHaveACollision(circle, size)) {
        continue;
      } else {
        circleSafeToDraw = true;
        break;
      }
    }

    if (!circleSafeToDraw) {
      return;
    }

    for (double i = minRaidus; i < maxRaidus; i++) {
      circle.radius = i;
      if (_doesHaveACollision(circle, size)) {
        circle.radius--;
        break;
      }
    }

    circles.add(circle);
  }

  void _drawCircles(Canvas canvas) {
    Paint paint = Paint()
      ..strokeWidth = 0.5
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke;

    circles.asMap().forEach((key, circle) {
      paint.color = Colors.black;
      Offset offset = Offset(circle.center.x.toDouble(), circle.center.y.toDouble());
      canvas.drawCircle(offset, circle.radius, paint);
    });
  }

  bool _doesHaveACollision(Circle circle, Size size) {
    for (int i = 0; i < circles.length; i++) {
      Circle otherCircle = circles[i];
      double r2 = circle.radius + otherCircle.radius;

      if (r2 >= circle.center.distanceTo(otherCircle.center) - 1) {
        return true;
      }
    }

    if (circle.center.x + circle.radius >= size.width ||
        circle.center.x - circle.radius <= 0) {
      return true;
    }

    if (circle.center.y + circle.radius >= size.height ||
        circle.center.y - circle.radius <= 0) {
      return true;
    }

    return false;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < totalCircles; i++) {
      _createCircles(canvas, size);
      _drawCircles(canvas);
    }
  }

  @override
  bool shouldRepaint(CirclePackingPainter oldDelegate) => true;

}
