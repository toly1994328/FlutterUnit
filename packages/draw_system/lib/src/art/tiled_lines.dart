import 'dart:math';
import 'package:flutter/material.dart';

class TiledLines extends StatefulWidget {
  const TiledLines({Key? key}) : super(key: key);

  @override
  _TiledLinesState createState() => _TiledLinesState();
}

class _TiledLinesState extends State<TiledLines> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {

        });
      },
      child: CustomPaint(
        painter: TiledLinesPainter(20),
      ),
    );
  }
}

class TiledLinesPainter extends CustomPainter {
  final double step;

  TiledLinesPainter(this.step);

  void _drawLine(
    Canvas canvas,
    double x,
    double y,
    double width,
    double height,
  ) {
    final bool isLeftToRight = Random().nextBool();

    final Paint paint = Paint()
      ..strokeCap = StrokeCap.square
      ..strokeWidth = 2;

    Offset p1;
    Offset p2;

    if (isLeftToRight) {
      p1 = Offset(x, y);
      p2 = Offset(x + width, y + height);
    } else {
      p1 = Offset(x + width, y);
      p2 = Offset(x, y + height);
    }

    canvas.drawLine(p1, p2, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromPoints(Offset.zero, Offset(size.width,size.height)));
    for (double x = 0; x < size.width; x += step) {
      for (double y = 0; y < size.height; y += step) {
        _drawLine(canvas, x, y, step, step);
      }
    }
  }

  @override
  bool shouldRepaint(TiledLinesPainter oldDelegate) => true;
}
