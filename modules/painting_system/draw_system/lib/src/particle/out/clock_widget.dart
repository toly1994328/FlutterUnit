import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'clock_fx.dart';

/// create by 张风捷特烈 on 2021/2/7
/// contact me by email 1981462002@qq.com
/// 说明:

class ClockWidget extends StatefulWidget {
  final double radius;

  const ClockWidget({Key? key, this.radius = 100}) : super(key: key);

  @override
  _ClockWidgetState createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  late ClockFx _fx;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_tick)..start();
    _fx = ClockFx(
      size: Size(widget.radius * 2, widget.radius * 2),
      time: DateTime.now(),
    );
  }

  @override
  void dispose() {
    _ticker.dispose();
    _fx.dispose();
    super.dispose();
  }

  void _tick(Duration duration) {
    _fx.tick(duration);
    if (_fx.time.second != DateTime.now().second) {
      _fx.setTime(DateTime.now());
    }
  }

  @override
  Widget build(BuildContext context) {
    return  CustomPaint(
        size: Size(widget.radius * 2, widget.radius * 2),
        painter: ClockFxPainter(fx: _fx),
    );
  }
}

/// Alpha value for noise particles.
const double noiseAlpha = 160;

class ClockFxPainter extends CustomPainter {
  final ClockFx fx;

  ClockFxPainter({required this.fx}) : super(repaint: fx);

  @override
  void paint(Canvas canvas, Size size) {
    for (var p in fx.particles) {
      double a;
      a = max(0.0, (p.distFrac - .13) / p.distFrac) * 255;
      a = min(a, min(noiseAlpha, p.lifeLeft * 3 * 255));
      int alpha = a.floor();

      Paint circlePaint = Paint()
        ..style = PaintingStyle.fill
        ..color = p.color.withAlpha(alpha);

      canvas.drawCircle(Offset(p.x, p.y), p.size, circlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant ClockFxPainter oldDelegate) =>
      oldDelegate.fx != fx;
}
