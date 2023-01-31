import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/3
/// contact me by email 1981462002@qq.com
/// 说明:

class WrapColor extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final double radius;
  final EdgeInsetsGeometry padding;

  const WrapColor(
      {Key? key, this.child,
       this.color,
      this.radius = 5,
      this.padding =
          const EdgeInsets.only(left: 4, right: 4, top: 0, bottom: 0)}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: child,
      padding: padding,
      decoration: BoxDecoration(
          color: color??Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(radius))),
    );
  }
}

class Circled extends StatelessWidget {
  final Widget child;
  final Color color;
  final double radius;

  const Circled({Key? key, required this.child, this.color = Colors.blue, this.radius = 15}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      child: child,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(radius))),
    );
  }
}
