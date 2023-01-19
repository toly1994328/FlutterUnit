import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 1,
//      "name": 'Container的约束性',
//      "priority": 6,
//      "subtitle":
//          "【constraints】 : 约束   【BoxConstraints】\n "
//              "会约束该区域的尺寸，不会小于指定的最小宽高，也不会大于指定的最大宽高。",
//    }
class ContainerConstraints extends StatelessWidget {
  const ContainerConstraints({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      width: 200,
      height: 200 * 0.618,
      constraints: const BoxConstraints(
        minWidth: 100,
        maxWidth: 150,
        minHeight: 20,
        maxHeight: 100,
      ),
    );
  }
}