import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020/4/27
/// contact me by email 1981462002@qq.com
/// 说明:
//      {
//      "widgetId": 30,
//      "priority": 1,
//      "name": "IconButton属性",
//      "subtitle": "【icon】: 图标组件   【Widget】\n"
//          "【tooltip】: 长按提示文字   【String】\n"
//          "【highlightColor】: 长按高亮色   【Color】\n"
//          "【splashColor】: 水波纹色   【Color】\n"
//          "【onPressed】: 点击事件   【Function】",
//      }

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        padding: const EdgeInsets.only(),
        onPressed: () {},
        icon: const Icon(Icons.android, size: 40, color: Colors.green),
        tooltip: "android",
        highlightColor: Colors.orangeAccent,
        splashColor: Colors.blue,
      ),
    );
  }
}
