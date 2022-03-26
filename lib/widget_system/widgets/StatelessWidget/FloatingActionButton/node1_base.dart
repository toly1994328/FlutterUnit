/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 28,
//      "priority": 1,
//      "name": "FloatingActionButton点击事件",
//      "subtitle": "【child】: 子组件   【Widget】\n"
//          "【tooltip】: 长按时提示文字   【String】\n"
//          "【backgroundColor】: 背景色   【Color】\n"
//          "【foregroundColor】: 前景色   【Color】\n"
//          "【elevation】: 影深   【double】\n"
//          "【onPressed】: 点击事件   【Function】",
//    }
import 'package:flutter/material.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<Color,IconData> data = {
      Colors.red: Icons.add,
      Colors.blue: Icons.bluetooth,
      Colors.green: Icons.android,
    };
    return Wrap(
        spacing: 20,
        children: data.keys
            .map((e) => FloatingActionButton(
          heroTag: e.toString()+"a",
          onPressed: () {},
          backgroundColor: e,
          foregroundColor: Colors.white,
          child: Icon(data[e]),
          tooltip: "android",
          elevation: 5, //z-阴影盖度
        )).toList());
  }
}