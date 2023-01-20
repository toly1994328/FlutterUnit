import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Panel extends StatelessWidget {
  final double radius;
  final Color? color;
  final Widget? child;

  const Panel({Key? key, this.radius = 5.0,  this.color, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      child: child,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: color ?? const Color(0xffF6F8FA),
          borderRadius: BorderRadius.all(Radius.circular(radius))),
    );
  }
}


