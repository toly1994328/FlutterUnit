import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 291,
//      "name": 'ListWheelViewport 透视效果',
//      "priority": 2,
//      "subtitle": "【perspective】 : 透视参数   【double】\n"
//          "【squeeze】 : 挤压值   【double】\n"
//          "【diameterRatio】 : 直径分率   【double】",
//    }

class ListWheelViewportDemo2 extends StatelessWidget {
  ListWheelViewportDemo2({Key? key}) : super(key: key);

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
                perspective: 0.008,
                squeeze: 1,
                diameterRatio: 2,
                itemExtent: 50,
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
              )
            ])),
  );

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}
