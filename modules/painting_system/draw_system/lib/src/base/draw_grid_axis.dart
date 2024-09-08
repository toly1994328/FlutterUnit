import 'package:flutter/material.dart';

import '../utils/coordinate.dart';

/// create by 张风捷特烈 on 2020/12/5
/// contact me by email 1981462002@qq.com
/// 说明:

class DrawGridAxis extends StatelessWidget {
  const DrawGridAxis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.shortestSide;
    return CustomPaint(size: Size(size, size), painter: PaperPainter());
  }
}

class PaperPainter extends CustomPainter {
  final Coordinate coordinate = Coordinate(yTop: true, numScale: 20);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    coordinate.paint(canvas, size);
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) => false;
}
