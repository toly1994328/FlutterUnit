import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 1,
//      "name": '可以在区域中放入一个子组件',
//      "priority": 2,
//      "subtitle": "【padding】 : 内边距   【EdgeInsetsGeometry】\n"
//          "【margin】: 外边距   【EdgeInsetsGeometry】\n"
//          "【child】: 子组件    【Widget】",
//    }
class ContainerWithChild extends StatelessWidget {
  const ContainerWithChild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(10),
      width: 200,
      height: 200 * 0.618,
      color: Colors.grey.withAlpha(88),
      child: const Icon(Icons.android),
    );
  }
}