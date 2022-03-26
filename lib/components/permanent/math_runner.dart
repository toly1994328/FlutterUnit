import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/10/24
/// contact me by email 1981462002@qq.com
/// 说明:

typedef FunNum1 = Function(double t);

class MathRunner extends StatefulWidget {
  const MathRunner(
      {Key? key,
      this.child,
      required this.f,
      required this.g,
      this.reverse = true})
      : super(key: key);

  final Widget? child;
  final FunNum1 f;
  final FunNum1 g;
  final bool reverse;

  @override
  _MathRunnerState createState() => _MathRunnerState();
}

class _MathRunnerState extends State<MathRunner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animationX;
  double _x = -1.0;
  double _y = 0;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: widget.reverse);
    animationX = Tween(begin: -1.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _x = widget.f(animationX.value);
          _y = widget.g(animationX.value);
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Alignment(_x, _y),
      child: widget.child,
    );
  }
}
