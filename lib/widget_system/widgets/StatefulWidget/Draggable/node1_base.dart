import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-22
/// contact me by email 1981462002@qq.com
/// 说明:
///
//    {
//      "widgetId": 103,
//      "name": 'Draggable基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子   【Widget】\n"
//          "【feedback】 : 拖拽时的孩子   【Widget】\n"
//          "【axis】 : 拖动的轴   【Axis】",
//    }
class CustomDraggable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var axis = [null, Axis.vertical, Axis.horizontal];
    return Wrap(
        spacing: 30,
        children: axis
            .map((e) => Draggable(
                  axis: e,
                  child: Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.blue, shape: BoxShape.circle),
                  ),
                  feedback: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                  ),
                ))
            .toList());
  }
}