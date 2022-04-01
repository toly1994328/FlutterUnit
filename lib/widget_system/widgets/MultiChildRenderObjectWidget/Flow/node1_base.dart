import 'dart:math';

import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-30
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 99,
//      "name": 'Flow圆形排布',
//      "priority": 1,
//      "subtitle": "【children】 : 组件列表   【List<Widget>】\n"
//          "【delegate】 : 代理   【FlowDelegate】",
//    }
class CircleFlow extends StatelessWidget {
  CircleFlow({Key? key}) : super(key: key);

  final List<String> data = List.generate(
      16,
      (index) => index.isEven
          ? "assets/images/icon_head.webp"
          : "assets/images/wy_300x200.webp");

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      alignment: Alignment.center,
      child: Flow(
        delegate: _CircleFlowDelegate(),
        children: data
            .map((e) => CircleAvatar(backgroundImage: AssetImage(e)))
            .toList(),
      ),
    );
  }
}

class _CircleFlowDelegate extends FlowDelegate {

  @override //绘制孩子的方法
  void paintChildren(FlowPaintingContext context) {
    final double radius = context.size.shortestSide / 2;
    final int count = context.childCount;
    final double perRad = 2 * pi / count;
    for (int i = 0; i < count; i++) {
      final Size size = context.getChildSize(i) ?? Size.zero;
      final double offsetX =
          (radius - size.width / 2) * cos(i * perRad) + radius;
      final double offsetY =
          (radius - size.height / 2) * sin(i * perRad) + radius;
      context.paintChild(i,
          transform: Matrix4.translationValues(
              offsetX - size.width / 2, offsetY - size.height / 2, 0.0));
    }
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) => false;
}
