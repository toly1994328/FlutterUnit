
import 'package:flutter/material.dart';


/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 228 AnimatedBuilder 动画构造器
/// 通过 builder 使动画对应的节点变为局部更新，并且可避免子组件刷新，减少构建的时间，提高动画性能。
///
//    {
//      "widgetId": 228,
//      "name": 'AnimatedBuilder 使用案例',
//      "priority": 1,
//      "subtitle":
//          "【animation】 : *可监听对象   【Listenable】\n"
//          "【builder】 : *组件构造器   【TransitionBuilder】\n"
//          "【child】 : 子组件   【Widget】",
//    }

class AnimatedBuilderDemo extends StatefulWidget {
  const AnimatedBuilderDemo({Key? key}) : super(key: key);

  @override
  _AnimatedBuilderDemoState createState() => _AnimatedBuilderDemoState();
}

class _AnimatedBuilderDemoState extends State<AnimatedBuilderDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        lowerBound: 0.3,
        upperBound: 1.0,
        duration: const Duration(milliseconds: 500))
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.forward(from: 0);
      },
      child: AnimatedBuilder(
          animation: controller,
          builder: (ctx, child) {
            return Transform.scale(
              scale: controller.value,
              child: Opacity(opacity: controller.value, child: child),
            );
          },
          child: buildChild()),
    );
  }

  Widget buildChild() => Container(
    height: 100,
        width: 100,
        decoration: const BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: const Text(
          'Toly',
          style: TextStyle(fontSize: 40, color: Colors.white),
        ),
      );
}
