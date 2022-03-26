import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 299 CupertinoTextSelectionToolbar  对文本选择做出响应的 ios 风格的工具栏。
//    {
//      "widgetId": 299,
//      "name": '该组件无法使用',
//      "priority": 1,
//      "subtitle":
//          "【-】 : -   【-】",
//    }

class CupertinoTextSelectionToolbarDemo extends StatelessWidget {
  const CupertinoTextSelectionToolbarDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        width: 300,
        child: const Text(
          "注：此组件私有构造器，外部无法使用，并没有使用价值。",
          style: TextStyle(color: Colors.red, fontSize: 18),
        ),
    );
  }
}
