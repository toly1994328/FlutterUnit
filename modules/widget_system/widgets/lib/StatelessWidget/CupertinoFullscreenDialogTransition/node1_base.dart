import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020/4/11
/// contact me by email 1981462002@qq.com
///


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
