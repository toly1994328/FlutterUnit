import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/27
/// contact me by email 1981462002@qq.com
/// 说明:

class ArcClipper extends CustomClipper<Path> {
  final double factor;

  ArcClipper({this.factor = 0.618});

  @override
  Path getClip(Size size) => Path()
    ..moveTo(0, 0)
    ..relativeLineTo(size.width, 0)
    ..relativeLineTo(0, 0.8 * size.height)
    ..arcToPoint(
      Offset(0.0, size.height * 0.618),
      radius: const Radius.elliptical(50.0, 10.0),
      rotation: 0.0,
    )
    ..close();

  @override
  bool shouldReclip(ArcClipper oldClipper) => factor != oldClipper.factor;
}
