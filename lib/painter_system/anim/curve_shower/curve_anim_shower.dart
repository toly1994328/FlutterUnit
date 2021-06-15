import 'dart:ui';

import 'package:flutter/material.dart';

import 'anim_painter.dart';
import 'point_data.dart';

class CurveAnimShower extends StatefulWidget {
  const CurveAnimShower();

  @override
  _CurveAnimShowerState createState() => _CurveAnimShowerState();
}

class _CurveAnimShowerState extends State<CurveAnimShower>
    with SingleTickerProviderStateMixin {
  PointData points = PointData();

  AnimationController _ctrl;

  final Duration animDuration = const Duration(milliseconds: 1000);

  Animation<double> curveAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: animDuration,
    )..addListener(_collectPoint);
    curveAnim = CurvedAnimation(parent: _ctrl, curve: Curves.bounceOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    points.dispose();
    super.dispose();
  }

  void _collectPoint() {
    points.push(curveAnim.value);
  }

  void _startAnim() async {
    points.clear();
    await _ctrl.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _startAnim,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: CustomPaint(
          painter: AnimPainter(points),
          size: const Size(
            200,
            200,
          ),
        ),
      ),
    );
  }
}
