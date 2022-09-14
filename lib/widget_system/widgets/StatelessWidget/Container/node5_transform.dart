import 'dart:math';

import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 1,
//      "name": 'Container还具有变换性',
//      "priority": 5,
//      "subtitle": "【transform】 : 变换矩阵   【Matrix4】\n "
//          "基于Matrix4的矩阵变换，变换详情见线性代数",
//    }
class ContainerTransform extends StatelessWidget {
  const ContainerTransform({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.cyanAccent,
      width: 150,
      height: 150 * 0.618,
      transform: Matrix4.skew(-pi / 10, 0),
      child: const Text(
        "Container",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}