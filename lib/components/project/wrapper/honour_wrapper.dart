import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2021/1/30
/// contact me by email 1981462002@qq.com
/// 说明:

class HonourWrapper extends StatefulWidget {
  final String username;

  const HonourWrapper({Key? key, this.username = '张风捷特烈'}) : super(key: key);

  @override
  _HonourWrapperState createState() => _HonourWrapperState();
}

class _HonourWrapperState extends State<HonourWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 5))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: HonourPainter(factor: _ctrl),
        child: Padding(
          padding: const EdgeInsets.only(right: 5, left: 5, top: 6, bottom: 6),
          child: Text(
            widget.username,
            style:
                const TextStyle(fontSize: 16, color: Colors.white, height: 1),
          ),
        ),
      ),
    );
  }
}

class HonourPainter extends CustomPainter {
  final Animation<double> factor;
  final TextPainter _textPainter = TextPainter(
      text: const TextSpan(
        text: '尊享',
        style: TextStyle(fontSize: 10, color: Colors.white, height: 1),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr);

  HonourPainter({required this.factor}) : super(repaint: factor);

  static const List<Color> colors = [
    Color(0xffFFAB40),
    Color(0xaaFFAB40),
    Color(0x88FFAB40),
    Color(0x55FFAB40),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRRect(
        RRect.fromRectXY(Offset.zero & size, 5, 5),
        Paint()
          ..color = const Color(0xaaFFAB40)
          ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 2)
          ..shader = ui.Gradient.linear(
              const Offset(0, 0), Offset(size.width, 0), colors, [0, 0.3, 0.6, 1.0]));
    canvas.drawLine(
      Offset.zero.translate(size.width * factor.value, 0),
      Offset.zero.translate(size.width * factor.value / 2, size.height),
      Paint()
        ..strokeWidth = 5
        ..color = Colors.blue.withOpacity(0.3)
        ..strokeCap = StrokeCap.round,
    );
    _textPainter.layout();
    canvas.drawRRect(
        RRect.fromRectXY(
            Offset.zero
                    .translate(size.width * factor.value - 3, -15 - 3.0)
                    .translate(-_textPainter.size.width / 2, 0) &
                (_textPainter.size + const Offset(6, 6)),
            5,
            5),
        Paint()..color = Colors.green);
    _textPainter.paint(
        canvas,
        Offset.zero
            .translate(size.width * factor.value, -15)
            .translate(-_textPainter.size.width / 2, 0));
  }

  @override
  bool shouldRepaint(covariant HonourPainter oldDelegate) =>
      oldDelegate.factor != factor;
}
