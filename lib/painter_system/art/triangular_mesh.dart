import 'dart:math';

import 'package:flutter/material.dart';
import '../utils/colors.dart';

class Point {
  double x=0;
  double y=0;
}

class TriangularMesh extends StatefulWidget {
  const TriangularMesh({Key? key}) : super(key: key);

  @override
  _TriangularMeshState createState() => _TriangularMeshState();
}

class _TriangularMeshState extends State<TriangularMesh> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {

        });
      },
      child: CustomPaint(
        painter: TriangularMeshPainter(),
      ),
    );
  }
}

class TriangularMeshPainter extends CustomPainter {
  void _drawTriangle(Canvas canvas, Point pointA, Point pointB, Point pointC) {
    Path path = Path();
    Paint fill = Paint()
      // ..color = Colors.black.withOpacity(Random().nextDouble() * .9)
      ..color = colors[Random().nextInt(colors.length)].withOpacity(.8)
      ..style = PaintingStyle.fill
      ..strokeJoin = StrokeJoin.bevel
      ..isAntiAlias = true;

    Paint line = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.bevel
      ..isAntiAlias = true;

    path.moveTo(pointA.x, pointA.y);
    path.lineTo(pointB.x, pointB.y);
    path.lineTo(pointC.x, pointC.y);
    path.lineTo(pointA.x, pointA.y);

    canvas.drawPath(path, fill);
    canvas.drawPath(path, line);
  }

  @override
  void paint(Canvas canvas, Size size) {
    List<List<Point>> lines = [];
    bool odd = false;
    List<Point> line;
    double gap = size.width / 8;

    for (double y = gap / 2; y <= size.height; y += gap) {
      odd = !odd;
      line = [];

      for (double x = gap / 4; x <= size.width; x += gap) {
        Point point = Point();
        double random = (Random().nextDouble() * .8 - .4) * gap;
        point.x = x + random + (odd ? gap / 2 : 0);
        point.y = y + (Random().nextDouble() * .8 - .4) * gap;
        line.add(point);
      }

      lines.add(line);
    }

    odd = true;
    List dotLine;

    for (int y = 0; y < lines.length - 1; y++) {
      odd = !odd;
      dotLine = [];
      for (int i = 0; i < lines[y].length; i++) {
        dotLine.add(odd ? lines[y][i] : lines[y + 1][i]);
        dotLine.add(odd ? lines[y + 1][i] : lines[y][i]);
      }

      for (int i = 0; i < dotLine.length - 2; i++) {
        _drawTriangle(canvas, dotLine[i], dotLine[i + 1], dotLine[i + 2]);
      }
    }
  }

  @override
  bool shouldRepaint(TriangularMeshPainter oldDelegate) => true;
}
