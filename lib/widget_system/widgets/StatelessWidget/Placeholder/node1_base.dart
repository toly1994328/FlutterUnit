import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 36,
//      "priority": 1,
//      "name": "Placeholder基础属性",
//      "subtitle": "【color】: 颜色   【Color】\n"
//          "【strokeWidth】: 线粗   【double】",
//    }
class CustomPlaceholder extends StatelessWidget {
  const CustomPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 100,
      height: 100*0.618,
      child:  Placeholder(
        color: Colors.orangeAccent,
        strokeWidth: 2,
      ),
    );
  }
}