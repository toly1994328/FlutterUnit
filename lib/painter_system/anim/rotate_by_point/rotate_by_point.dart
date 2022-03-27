import 'dart:math';

import 'package:flutter/material.dart';

import 'angle_panter.dart';
import 'line.dart';

class RotateByPointWidget extends StatefulWidget {
  const RotateByPointWidget({Key? key}) : super(key: key);

  @override
  State<RotateByPointWidget> createState() => _RotateByPointWidgetState();
}

class _RotateByPointWidgetState extends State<RotateByPointWidget>
    with SingleTickerProviderStateMixin {

  Line line = Line(start: const Offset(20, 20), end: const Offset(50, 80));

  late AnimationController ctrl;

  @override
  void initState() {
    super.initState();
    ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(_updateLine);
  }

  @override
  void dispose() {
    line.dispose();
    ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => ctrl.forward(from: 0),
      child: CustomPaint(
        painter: AnglePainter(line: line),
        size: const Size(200,200),
      ),
    );
  }

  void _updateLine() {
    Offset center = line.percent(0.2);
    line.rotate(ctrl.value * 2 * pi, centre: center);
  }
}
