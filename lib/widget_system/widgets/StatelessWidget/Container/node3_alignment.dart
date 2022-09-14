import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 1,
//      "name": '可对子组件进行对齐定位',
//      "priority": 3,
//      "subtitle": "【alignment】 : 对齐定位   【AlignmentGeometry】",
//    }
class ContainerAlignment extends StatelessWidget {
  const ContainerAlignment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      width: 200,
      height: 200 * 0.618,
      color: Colors.grey.withAlpha(88),
      child: const Icon(
        Icons.android,
        color: Colors.green,
      ),
    );
  }
}