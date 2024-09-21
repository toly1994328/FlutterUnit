
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com


class TweenAnimationBuilderDemo extends StatefulWidget {
  const TweenAnimationBuilderDemo({Key? key}) : super(key: key);

  @override
  _TweenAnimationBuilderDemoState createState() =>
      _TweenAnimationBuilderDemoState();
}

class _TweenAnimationBuilderDemoState extends State<TweenAnimationBuilderDemo> {
  Color _value = Colors.red;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: ColorTween(begin: Colors.blue, end: _value),
      duration: const Duration(milliseconds: 800),
      builder: (BuildContext context, Color? color, Widget? child) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _value = _value == Colors.red ? Colors.blue : Colors.red;
            });
          },
          child: Container(
            width: 40,
            height: 40,
            child: child,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(5)
            ),
          ),
        );
      },
      child: const Icon(
        Icons.android_outlined,
        color: Colors.white,
      ),
    );
  }
}
