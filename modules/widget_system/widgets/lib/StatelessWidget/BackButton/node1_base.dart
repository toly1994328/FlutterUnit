import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 31,
//      "priority": 1,
//      "name": "BackButton属性",
//      "subtitle": "【color】: 颜色   【Color】\n"
//          "【style】: 按钮样式   【ButtonStyle?】\n"
//          "【onPressed】: 点击事件   【Function】\n"
//          " onPressed为空会退出当前栈",
//    }
class CustomBackButton extends StatelessWidget {
  CustomBackButton({Key? key}) : super(key: key);

  final List<Color> data = [
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.green
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 10,
        children: data
            .map((e) => BackButton(
                  color: e,
                ))
            .toList());
  }
}
