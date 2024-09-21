import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/11
/// contact me by email 1981462002@qq.com
///

class CupertinoPageTransitionDemo extends StatelessWidget {
  const CupertinoPageTransitionDemo({Key? key}) : super(key: key);

  final String info =
      '该组件底层基于 SlideTransition 组件实现，主要用途是模仿 iOS 风格，处理页面间跳转的过渡动画。'
      '源码中唯一的使用处是 CupertinoPageRoute 处理路由跳转动画时，一般不会单独使用。'
      '如 A 跳转到 B， primaryRouteAnimation 和 secondaryRouteAnimation 都是一个 0.0->1.0 的动画，'
      '前者用于处理 B 界面进入过渡动画；后者用于处理 A 界面被覆盖的过渡动画。';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.withOpacity(0.1),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Text(info ),
    );
  }
}
