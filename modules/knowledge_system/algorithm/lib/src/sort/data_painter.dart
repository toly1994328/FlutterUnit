import 'package:flutter/material.dart';

class DataPainter extends CustomPainter {
  final List<int> data;

  DataPainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    double itemWidth = size.width / data.length;

    Paint paint = Paint();
    paint.strokeWidth = itemWidth;
    paint.strokeCap = StrokeCap.round;

    for (int i = 0; i < data.length; i++) {
      int value = data[i];
      if (value < 1000 * .10) {
        paint.color = Colors.blue.shade100;
      } else if (value < 1000 * .20) {
        paint.color = Colors.blue.shade200;
      } else if (value < 1000 * .30) {
        paint.color = Colors.blue.shade300;
      } else if (value < 1000 * .40) {
        paint.color = Colors.blue.shade400;
      } else if (value < 1000 * .50) {
        paint.color = Colors.blue.shade500;
      } else if (value < 1000 * .60) {
        paint.color = Colors.blue.shade600;
      } else if (value < 1000 * .70) {
        paint.color = Colors.blue.shade700;
      } else if (value < 1000 * .80) {
        paint.color = Colors.blue.shade800;
      } else if (value < 1000 * .90) {
        paint.color = Colors.blue.shade900;
      } else {
        paint.color = const Color(0xFF011E51);
      }
      canvas.drawLine(
          Offset(i * itemWidth + itemWidth / 2, 0),
          Offset(
            i * itemWidth + itemWidth / 2,
            size.height * (value / 1000),
          ),
          paint);
    }
  }

  @override
  bool shouldRepaint(covariant DataPainter oldDelegate) {
    return true;
  }
}
