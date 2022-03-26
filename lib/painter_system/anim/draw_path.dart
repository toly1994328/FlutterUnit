import 'dart:math';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/5/1
/// contact me by email 1981462002@qq.com
/// 说明:

class DrawPath extends StatefulWidget {
  const DrawPath({Key? key}) : super(key: key);

  @override
  _DrawPathState createState() => _DrawPathState();
}

class _DrawPathState extends State<DrawPath> with SingleTickerProviderStateMixin {
 late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: PaperPainter(_controller),
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  final Animation<double> repaint;

  PaperPainter(this.repaint) : super(repaint: repaint) {
    initPointsWithPolar();
  }

  final List<Offset> points = [];
  final Path path = Path();
  final double step = 4;
  final double min = 0;
  final double max = 360;

  void initPointsWithPolar() {
    for (double x = min; x < max; x += step) {
      double thta = (pi / 180 * x); // 角度转化为弧度
      var p = f(thta);
      points.add(Offset(p * cos(thta), p * sin(thta)));
    }
    double thta = (pi / 180 * max);
    points.add(Offset(f(thta) * cos(thta), f(thta) * sin(thta)));
    points.add(Offset(f(thta) * cos(thta), f(thta) * sin(thta)));
  }

  double f(double thta) {
    double p = 120 * sin(5 * thta).abs();
    return p;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);

    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    List<Color> colors = const [
      Color(0xFFF60C0C),
      Color(0xFFF3B913),
      Color(0xFFE7F716),
      Color(0xFF3DF30B),
      Color(0xFF0DF6EF),
      Color(0xFF0829FB),
      Color(0xFFB709F4),
    ];
    var pos = [1.0 / 7, 2.0 / 7, 3.0 / 7, 4.0 / 7, 5.0 / 7, 6.0 / 7, 1.0];

    paint.shader = ui.Gradient.linear(
      const Offset(0, 0),
      const Offset(100, 0),
      colors,
      pos,
      TileMode.mirror,
    );

    Offset p1 = points[0];

    path.reset();
    path.moveTo(p1.dx, p1.dy);

    for (var i = 1; i < points.length - 1; i++) {
      double xc = (points[i].dx + points[i + 1].dx) / 2;
      double yc = (points[i].dy + points[i + 1].dy) / 2;
      Offset p2 = points[i];
      path.quadraticBezierTo(p2.dx, p2.dy, xc, yc);
    }



    PathMetrics pms = path.computeMetrics();
    for (PathMetric pm in pms) {
      Tangent? tangent = pm.getTangentForOffset(pm.length * repaint.value);
      canvas.drawPath(pm.extractPath(0, pm.length * repaint.value), paint);
      canvas.drawCircle(
          tangent?.position??Offset.zero, 5, Paint()..color = Colors.blue);
    }
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) =>
      oldDelegate.repaint != repaint;
}
