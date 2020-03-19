import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  final Color color;
  final double radius;

  Circle({this.color=Colors.blue, this.radius=6});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2*radius,
      height: 2*radius,
      decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle
      ),
    );
  }
}
