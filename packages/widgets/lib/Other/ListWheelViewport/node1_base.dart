import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 291 ListWheelViewport 列表滚轮视口 一个将孩子列表显示在柱状滚轮上的视口，是 ListWheelScrollView、CupertinoPicker 的底层依赖。
/// link 179,139,137,253
///
//    {
//      "widgetId": 291,
//      "name": 'ListWheelViewport 简单使用',
//      "priority": 1,
//      "subtitle": "【itemExtent】 : 轴向item尺寸   【double】\n"
//          "【offset】 : 视口偏移   【ViewportOffset】\n"
//          "【childDelegate】 : 孩子代理构造器   【ListWheelChildDelegate】",
//    }

class ListWheelViewportDemo extends StatelessWidget {
  ListWheelViewportDemo({Key? key}) : super(key: key);

  final List<Color> data = [
    Colors.blue[50]!,
    Colors.blue[100]!,
    Colors.blue[200]!,
    Colors.blue[300]!,
    Colors.blue[400]!,
    Colors.blue[500]!,
    Colors.blue[600]!,
    Colors.blue[700]!,
    Colors.blue[800]!,
    Colors.blue[900]!,
    Colors.blue[800]!,
    Colors.blue[700]!,
    Colors.blue[600]!,
    Colors.blue[500]!,
    Colors.blue[400]!,
    Colors.blue[300]!,
    Colors.blue[200]!,
    Colors.blue[100]!,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 320,
      child: Scrollable(
          axisDirection: AxisDirection.down,
          physics: const BouncingScrollPhysics(),
          dragStartBehavior: DragStartBehavior.start,
          viewportBuilder: (ctx, position) => ListWheelViewport(
                itemExtent: 100,
                offset: position,
                childDelegate: ListWheelChildLoopingListDelegate(
                    children: data.map((e) => _buildItem(e)).toList()),
              )),
    );
  }

  Widget _buildItem(Color color) => Container(
        alignment: Alignment.center,
        color: color,
        child: Text(colorString(color),
            style: const TextStyle(color: Colors.white, shadows: [
              Shadow(
                color: Colors.black,
                offset: Offset(.5, .5),
                blurRadius: 2,
              ),
            ])),
      );

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}
