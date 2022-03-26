import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'stamp_data.dart';

class StampPaper extends StatefulWidget {
  const StampPaper({Key? key}) : super(key: key);

  @override
  _StampPaperState createState() => _StampPaperState();
}

class _StampPaperState extends State<StampPaper>
    with SingleTickerProviderStateMixin {
  final StampData stamps = StampData();
  int gridCount = 3;
  double radius = 0;
  double width = 0;
  GameState gameState = GameState.doing;

  bool get gameOver => gameState != GameState.doing;

  // 定义动画器
  late AnimationController _controller;
  final Duration animDuration = const Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: animDuration)
      ..addListener(_listenAnim);
  }

  void _listenAnim() {
    if (_controller.value == 1.0) {
      _controller.reverse();
    }
    double rate = (0.9 - 1) * _controller.value + 1;
    stamps.animateAt(containsIndex, rate * radius);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.shortestSide * 0.8;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onDoubleTap: _clear,
      onTapCancel: _removeLast,
      child: CustomPaint(
        foregroundPainter: StampPainter(stamps: stamps, count: gridCount),
        painter: BackGroundPainter(count: gridCount),
        size: Size(width, width),
      ),
    );
  }

  bool get contains => containsIndex != -1;

  void _onTapDown(TapDownDetails details) {
    if (gameOver) return;

    containsIndex = checkZone(details.localPosition);
    if (contains) {
      _controller.forward();
      return;
    }

    radius = width / 2 / gridCount * 0.618;
    stamps.push(Stamp(
        radius: radius, center: details.localPosition, color: Colors.grey));
  }

  int containsIndex = -1;

  int checkZone(Offset src) {
    for (int i = 0; i < stamps.stamps.length; i++) {
      Rect zone = Rect.fromCircle(
          center: stamps.stamps[i].center, radius: width / gridCount / 2);
      if (zone.contains(src)) {
        return i;
      }
    }
    return -1;
  }

  void _onTapUp(TapUpDetails details) {
    if (contains || gameOver) return;

    stamps.activeLast(
        color: stamps.stamps.length % 2 == 0 ? Colors.red : Colors.blue);

    gameState = stamps.checkWin(width / gridCount);
    if (gameState == GameState.redWin) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("红棋获胜!"),
        backgroundColor: Colors.red,
      ));
    }

    if (gameState == GameState.blueWin) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("蓝棋获胜!"), backgroundColor: Colors.blue));
    }
  }

  void _clear() {
    stamps.clear();
    gameState=GameState.doing;
  }

  void _removeLast() {
    if (contains || gameOver) return;

    stamps.removeLast();
  }

  @override
  void dispose() {
    stamps.dispose();
    super.dispose();
  }
}

class BackGroundPainter extends CustomPainter {
  BackGroundPainter({this.count = 3});

  final int count;

  final Paint _pathPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  static const List<Color> colors = [
    Color(0xFFF60C0C),
    Color(0xFFF3B913),
    Color(0xFFE7F716),
    Color(0xFF3DF30B),
    Color(0xFF0DF6EF),
    Color(0xFF0829FB),
    Color(0xFFB709F4),
  ];

  static const List<double> pos = [
    1.0 / 7,
    2.0 / 7,
    3.0 / 7,
    4.0 / 7,
    5.0 / 7,
    6.0 / 7,
    1.0
  ];

  @override
  void paint(Canvas canvas, Size size) {
    Rect zone = Offset.zero & size;
    canvas.clipRect(zone);

    _pathPaint.shader = ui.Gradient.sweep(
        Offset(size.width / 2, size.height / 2),
        colors,
        pos,
        TileMode.mirror,
        pi / 2,
        pi);

    canvas.save();
    for (int i = 0; i < count - 1; i++) {
      canvas.translate(0, size.height / count);
      canvas.drawLine(Offset.zero, Offset(size.width, 0), _pathPaint);
    }
    canvas.restore();

    canvas.save();
    for (int i = 0; i < count - 1; i++) {
      canvas.translate(size.width / count, 0);
      canvas.drawLine(Offset.zero, Offset(0, size.height), _pathPaint);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant BackGroundPainter oldDelegate) {
    return count != oldDelegate.count;
  }
}

class StampPainter extends CustomPainter {
  final StampData stamps;
  final int count;
  final Paint _paint = Paint();
  final Paint _pathPaint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke;

  StampPainter({required this.stamps, this.count = 3}) : super(repaint: stamps);

  @override
  void paint(Canvas canvas, Size size) {
    Rect zone = Offset.zero & size;
    canvas.clipRect(zone);

    for (Stamp stamp in stamps.stamps) {
      double length = size.width / count;
      int x = stamp.center.dx ~/ (size.width / count);
      int y = stamp.center.dy ~/ (size.width / count);
      double strokeWidth = stamp.radius * 0.07;

      Offset center = Offset(length * x + length / 2, length * y + length / 2);
      stamp.center = center;
      canvas.drawCircle(
          stamp.center, stamp.radius, _paint..color = stamp.color);
      canvas.drawPath(
          stamp.path,
          _pathPaint
            ..strokeWidth = strokeWidth
            ..color = Colors.white);
      canvas.drawCircle(stamp.center, stamp.radius + strokeWidth * 1.5,
          _pathPaint..color = stamp.color);
    }
  }

  @override
  bool shouldRepaint(covariant StampPainter oldDelegate) {
    return stamps != oldDelegate.stamps || count != oldDelegate.count;
  }
}
