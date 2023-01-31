import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/11
/// contact me by email 1981462002@qq.com
///
/// 说明: 216 CupertinoPageTransition 0 风格的页面过渡动画变换 提供一个 iOS 风格的页面过渡动画。 link 219
//    {
//      "widgetId": 216,
//      "name": 'CupertinoPageTransition 介绍',
//      "priority": 1,
//      "subtitle": "【child】 : 子组件   【Widget】\n"
//          "【linearTransition】 : 是否线性转换   【bool】\n"
//          "【primaryRouteAnimation】 : 初始路由动画   【Animation<double>】\n"
//          "【secondaryRouteAnimation】 : 第二路由动画   【Animation<double>】",
//    }
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
