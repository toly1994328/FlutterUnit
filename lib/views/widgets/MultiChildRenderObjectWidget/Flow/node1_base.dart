import 'dart:math';

import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-30
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 99,
//      "name": 'Flow圆形排布',
//      "priority": 1,
//      "subtitle":
//          "【children】 : 组件列表   【List<Widget>】\n"
//          "【delegate】 : 代理   【FlowDelegate】",
//    }
class CircleFlow extends StatelessWidget {
  final data = List.generate(
      16,
      (index) => index.isEven
          ? "assets/images/icon_head.png"
          : "assets/images/wy_300x200.jpg");

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
    double radius = context.size.shortestSide / 2;
    print(context.getChildSize(0));
    var count = context.childCount;
    var perRad = 2 * pi / count;
    for (int i = 0; i < count; i++) {
      var cSizeX = context.getChildSize(i).width / 2;
      var cSizeY = context.getChildSize(i).height / 2;

      var offsetX = (radius - cSizeX) * cos(i * perRad) + radius;
      var offsetY = (radius - cSizeY) * sin(i * perRad) + radius;
      context.paintChild(i,
          transform: Matrix4.translationValues(
              offsetX - cSizeX, offsetY - cSizeY, 0.0));
    }
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return true;
  }
}
