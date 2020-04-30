import 'dart:math';

import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-30
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 99,
//      "name": 'Flow圆形与动画结合',
//      "priority": 2,
//      "subtitle":
//          "通过动画来更改周围组件的位置实现效果",
//    }

class BurstFlow extends StatefulWidget {
  static final data = List.generate(
      16,
      (index) => index.isEven
          ? "assets/images/icon_head.png"
          : "assets/images/wy_300x200.jpg");
  static final show = Container(
      width: 300,
      height: 300,
      alignment: Alignment.center,
      child: BurstFlow(
          children: data
              .map((e) => CircleAvatar(backgroundImage: AssetImage(e)))
              .toList(),
          menu: CircleAvatar(
            backgroundImage: AssetImage('assets/images/icon_head.png'),
          )));

  final List<Widget> children;
  final Widget menu;

  BurstFlow({@required this.children, @required this.menu});

  @override
  _BurstFlowState createState() => _BurstFlowState();
}

class _BurstFlowState extends State<BurstFlow>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  double _rad = 0.0;
  bool _closed = true;

  @override
  void initState() {
    _controller = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this)
      ..addListener(() => setState(
          () => _rad = (_closed ? (_controller.value) : 1 - _controller.value)))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _closed = !_closed;
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: _BurstFlowDelegate(_rad),
      children: [
        ...widget.children,
        InkWell(
            onTap: () {
              _controller.reset();
              _controller.forward();
            },
            child: widget.menu)
      ],
    );
  }
}

class _BurstFlowDelegate extends FlowDelegate {
  final double rad;

  _BurstFlowDelegate(this.rad);

  @override //绘制孩子的方法
  void paintChildren(FlowPaintingContext context) {
    double radius = context.size.shortestSide / 2;
    var count = context.childCount - 1;
    var perRad = 2 * pi / count;
    for (int i = 0; i < count; i++) {
      print(i);
      var cSizeX = context.getChildSize(i).width / 2;
      var cSizeY = context.getChildSize(i).height / 2;
      var offsetX = rad * (radius - cSizeX) * cos(i * perRad) + radius;
      var offsetY = rad * (radius - cSizeY) * sin(i * perRad) + radius;
      context.paintChild(i,
          transform: Matrix4.translationValues(
              offsetX - cSizeX, offsetY - cSizeY, 0.0));
    }
    context.paintChild(context.childCount - 1,
        transform: Matrix4.translationValues(
            radius - context.getChildSize(context.childCount - 1).width / 2,
            radius - context.getChildSize(context.childCount - 1).height / 2,
            0.0));
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return true;
  }
}
