
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com


class TweenAnimationBuilderDemo extends StatefulWidget {
  const TweenAnimationBuilderDemo({Key? key}) : super(key: key);

  @override
  State<TweenAnimationBuilderDemo> createState() =>
      _TweenAnimationBuilderDemoState();
}

class _TweenAnimationBuilderDemoState extends State<TweenAnimationBuilderDemo> {
  List<Color> get colors => const [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple
  ];

  int _activeIndex = 0;

  Color get begin => colors[_activeIndex % colors.length];

  Color get end => colors[(_activeIndex + 1) % colors.length];

  void nextColor(){
    _activeIndex++;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: nextColor,
      child: TweenAnimationBuilder(
        tween: ColorTween(begin: begin, end: end),
        duration: const Duration(milliseconds: 800),
        builder: (BuildContext context, Color? color, Widget? child) {
          return Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(5)),
            child: child,
          );
        },
        child: const Icon(Icons.android_outlined, color: Colors.white),
      ),
    );
  }
}