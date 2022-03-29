import 'dart:math';

import 'package:flutter/material.dart';

class JoyDivision extends StatefulWidget {
  const JoyDivision({Key? key}) : super(key: key);

  @override
  _JoyDivisionState createState() => _JoyDivisionState();
}

class _JoyDivisionState extends State<JoyDivision> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {

        });
      },
      child: CustomPaint(
        painter: JoyDivisionPainter(),
      ),
    );
  }
}

class JoyDivisionPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double step = 10;

    List<List<Point>> lines = [];

    for (double i = step; i <= width - step; i += step) {
      List<Point> line = [];
      for (double j = step; j <= width - step; j += step) {
        double distanceToCenter = (j - width / 2).abs();
        double variance = max(width / 2 - 50 - distanceToCenter, 0);
        double random = Random().nextDouble() * variance / 2 * -1;
        Point point = Point(j, i + random);
        line.add(point);
      }
      lines.add(line);
    }

    Paint paint = Paint()
      ..strokeWidth = 1.3
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      // ..strokeCap=StrokeCap.round
      ..isAntiAlias = true;

    for (int i = 5; i < lines.length; i++) {
      Point p1 = lines[i][0];
      Path path = Path()..moveTo(p1.x.toDouble(), p1.y.toDouble());

      for (int j = 0; j < lines[i].length - 2; j++) {
        double xc = (lines[i][j].x + lines[i][j + 1].x) / 2;
        double yc = (lines[i][j].y + lines[i][j + 1].y) / 2;

        Point p2 = lines[i][j];
        path.quadraticBezierTo(p2.x.toDouble(), p2.y.toDouble(), xc, yc);
        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(JoyDivisionPainter oldDelegate) => true;
  
}
