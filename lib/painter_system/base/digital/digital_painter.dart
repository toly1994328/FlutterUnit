import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'digital_path.dart';

class DigitalPainter extends CustomPainter {
  final int value;
  final Color color;
  final DigitalPath digitalPath;
  late Paint _mainPainter;

  DigitalPainter({required this.value,required this.digitalPath,required this.color}){
    _mainPainter = Paint()..style=PaintingStyle.fill..color=color;
  }


  @override
  void paint(Canvas canvas, Size size) {
    Path path = digitalPath.buildPath(value, size.width);
    canvas.drawPath(path, _mainPainter);
  }

  @override
  bool shouldRepaint(covariant DigitalPainter oldDelegate) {
    return oldDelegate.value != value;
  }
}
