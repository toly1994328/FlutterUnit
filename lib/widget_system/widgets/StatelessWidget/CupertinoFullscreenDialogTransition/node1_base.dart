import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020/4/11
/// contact me by email 1981462002@qq.com
///
/// 说明: 219 CupertinoFullscreenDialogTransition 0 全页面过渡变换 创建一个 iOS 风格的转换，用于唤出全屏对话框。link 216
//    {
//      "widgetId": 219,
//      "name": '组件介绍',
//      "priority": 1,
//      "subtitle": "【child】 : 子组件   【Widget】\n"
//          "【linearTransition】 : 是否线性转换   【bool】\n"
//          "【primaryRouteAnimation】 : 初始路由动画   【Animation<double>】\n"
//          "【secondaryRouteAnimation】 : 第二路由动画   【Animation<double>】",
//    }

class CupertinoFullscreenDialogTransitionDemo extends StatelessWidget {
  const CupertinoFullscreenDialogTransitionDemo({Key? key}) : super(key: key);

  final String info =
      '和 CupertinoPageTransition 一样，该组件底层基于 SlideTransition 组件实现，'
      '主要用途是模仿 iOS 风格，用于唤出全屏对话框动画过渡效果。'
      '源码中唯一的使用处是 CupertinoPageRoute 处理路由跳转动画时，一般不会单独使用。'
      '当【route.fullscreenDialog】为 true 时，会使用 CupertinoFullscreenDialogTransition 组件，否则使用 CupertinoPageTransition 组件。'
      '其中个属性信息和 CupertinoPageTransition 组件一致，详见之。';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.withOpacity(0.1),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Text(info),
    );
  }
}
