import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 344 NestedScrollViewViewport 嵌套滑动视口
/// 在 NestedScrollView 中使用的视口，该视口持有 SliverOverlapAbsorberHandle，会在视口需要重新计算布局时通知它。例如，当滚动它时。
///
//    {
//      "widgetId": 344,
//      "name": 'NestedScrollViewViewport 介绍',
//      "priority": 1,
//      "subtitle":
//          "【offset】 : *偏移   【ViewportOffset】\n"
//          "【handle】 : *处理器   【SliverOverlapAbsorberHandle】\n"
//          "【axisDirection】 : 轴向   【AxisDirection】\n"
//          "【crossAxisDirection】 : 交叉轴向   【AxisDirection】\n"
//          "【slivers】 : 子组件   【List<Widget>】\n"
//          "【clipBehavior】 : 裁剪行为   【Clip】\n"
//          "【anchor】 : 锚点   【double】",
//    }

class NestedScrollViewViewportDemo extends StatelessWidget {
  const NestedScrollViewViewportDemo({Key? key}) : super(key: key);

  final String info =
      'NestedScrollViewViewport 在源码中只有一处使用：'
      '_NestedScrollViewCustomScrollView 继承自 CustomScrollView，复写了 buildViewport 方法，返回 NestedScrollViewViewport 。'
      '而 NestedScrollView 构建时使用了 _NestedScrollViewCustomScrollView，也就是 NestedScrollView 的视口依赖于 NestedScrollViewViewport。'
      'NestedScrollViewViewport 的特点是持有 SliverOverlapAbsorberHandle 类对象 handle，源码中该 handle 在 NestedScrollViewState 中初始化。'
      '可通过上下文获取，用于 SliverOverlapAbsorber/SliverOverlapInjector 组件，使用详见相关组件。';


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
