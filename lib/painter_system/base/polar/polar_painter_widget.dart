
import 'package:flutter/material.dart';
import 'angle_painter.dart';

class PolarPainterWidget extends StatelessWidget {
  const PolarPainterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PolarPainter(),
      size: const Size(200,200),
    );
  }
}
