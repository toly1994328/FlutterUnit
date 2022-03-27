import 'dart:math';

import 'package:flutter/cupertino.dart';

class Polar2D {
  final double rad;
  final double length;

  final Offset coo;

  Polar2D(this.rad, this.length,{this.coo=Offset.zero});

  Offset get offset => Offset(
        cos(rad) * length-coo.dx,
        sin(rad) * length-coo.dy,
      );
}
