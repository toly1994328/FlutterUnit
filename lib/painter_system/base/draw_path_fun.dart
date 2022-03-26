import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
// import '../coordinate_pro.dart';

/// create by 张风捷特烈 on 2020/5/1
/// contact me by email 1981462002@qq.com
/// 说明:

class DrawPathFun extends StatelessWidget {
  const DrawPathFun({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.shortestSide;
    return Container(
      color: Colors.white,
      child: CustomPaint(
        size: Size(size, size),
        // 使用CustomPaint
        painter: PaperPainter(),
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  // final Coordinate coordinate = Coordinate();

  final List<Offset> points = [];

  final double step = 6;
  final double min = -240;
  final double max = 240;
  final List<Color> colors = const[
    Color(0xFFF60C0C),
    Color(0xFFF3B913),
    Color(0xFFE7F716),
    Color(0xFF3DF30B),
    Color(0xFF0DF6EF),
    Color(0xFF0829FB),
    Color(0xFFB709F4),
  ];

  void initPoints() {
    for (double x = min; x < max; x += step) {
      points.add(Offset(x, f(x)));
    }
    points.add(Offset(max, f(max)));
    points.add(Offset(max, f(max)));
  }

  void initPointsWithPolar() {
    for (double x = min; x < max; x += step) {
      double thta = (pi / 180 * x); // 角度转化为弧度
      var p = f(thta);
      points.add(Offset(p * cos(thta), p * sin(thta)));
    }
  }

  double f(double thta) {
    double p =
        40 * (pow(e, cos(thta)) - 2 * cos(4 * thta) + pow(sin(thta / 12), 5));
    return p;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    initPointsWithPolar();
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    var pos = [1.0 / 7, 2.0 / 7, 3.0 / 7, 4.0 / 7, 5.0 / 7, 6.0 / 7, 1.0];

    paint.shader = ui.Gradient.linear(
        const Offset(0, 0), const Offset(100, 0), colors, pos, TileMode.mirror);

    Offset p1 = points[0];
    Path path = Path()..moveTo(p1.dx, p1.dy);

    for (var i = 1; i < points.length - 1; i++) {
      double xc = (points[i].dx + points[i + 1].dx) / 2;
      double yc = (points[i].dy + points[i + 1].dy) / 2;
      Offset p2 = points[i];
      path.quadraticBezierTo(p2.dx, p2.dy, xc, yc);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
