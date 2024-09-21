import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-01
/// contact me by email 1981462002@qq.com

class AnimatedModalBarrierDemo extends StatefulWidget {
  const AnimatedModalBarrierDemo({Key? key}) : super(key: key);

  @override
  _AnimatedModalBarrierDemoState createState() =>
      _AnimatedModalBarrierDemoState();
}

class _AnimatedModalBarrierDemoState extends State<AnimatedModalBarrierDemo>
    with SingleTickerProviderStateMixin {
 late AnimationController _controller;
 late Animation<Color?> _color;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();
    _color = ColorTween(
      begin: Colors.blue,
      end: Colors.purple,
    ).animate(_controller);
  }

  @override
  void dispose() {
   _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 100,
      child: Stack(alignment: Alignment.center, children: [
        AnimatedModalBarrier(
          dismissible: true,
          color: _color,
        ),
        const Text(
          '点击背景返回',
          style: TextStyle(color: Colors.white),
        )
      ]),
    );
  }
}
