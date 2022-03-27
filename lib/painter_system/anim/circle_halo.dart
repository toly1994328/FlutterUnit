import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class CircleHalo extends StatefulWidget {
  const CircleHalo({Key? key}) : super(key: key);

  @override
  _CircleHaloState createState() => _CircleHaloState();
}

class _CircleHaloState extends State<CircleHalo>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _ctrl.repeat();

  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  CustomPaint(
        size: const Size(200, 200),
        painter: CircleHaloPainter(_ctrl),
      );
  }
}

class CircleHaloPainter extends CustomPainter {
  Animation<double> animation;

  CircleHaloPainter(this.animation) : super(repaint: animation);

  final Animatable<double> rotateTween = Tween<double>(begin: 0, end: 2 * pi)
      .chain(CurveTween(curve: Curves.easeIn));

  final Animatable<double> breatheTween = TweenSequence<double>(
    <TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0, end: 4),
        weight: 1,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 4, end: 0),
        weight: 1,
      ),
    ],
  ).chain(CurveTween(curve: Curves.decelerate));

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    final Paint paint = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    Path circlePath = Path()
      ..addOval(Rect.fromCenter(center: const Offset(0, 0), width: 100, height: 100));
    Path circlePath2 = Path()
      ..addOval(
          Rect.fromCenter(center: const Offset(-1, 0), width: 100, height: 100));
    Path result =
        Path.combine(PathOperation.difference, circlePath, circlePath2);

    List<Color> colors = [
      const Color(0xFFF60C0C),
      const Color(0xFFF3B913),
      const Color(0xFFE7F716),
      const Color(0xFF3DF30B),
      const Color(0xFF0DF6EF),
      const Color(0xFF0829FB),
      const Color(0xFFB709F4),
    ];
    colors.addAll(colors.reversed.toList());
    final List<double> pos =
        List.generate(colors.length, (index) => index / colors.length);

    paint.shader =
        ui.Gradient.sweep(Offset.zero, colors, pos, TileMode.clamp, 0, 2 * pi);

    paint.maskFilter =
        MaskFilter.blur(BlurStyle.solid, breatheTween.evaluate(animation));
    canvas.drawPath(circlePath, paint);

    canvas.save();
    canvas.rotate(animation.value * 2 * pi);
    paint
      ..style = PaintingStyle.fill
      ..color = const Color(0xff00abf2);
    paint.shader=null;
    canvas.drawPath(result, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CircleHaloPainter oldDelegate) =>
      oldDelegate.animation != animation;
}
