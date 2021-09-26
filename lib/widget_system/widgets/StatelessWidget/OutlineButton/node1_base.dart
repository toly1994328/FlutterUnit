import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 27,
//      "priority": 1,
//      "name": "OutlineButton点击事件",
//      "subtitle": "【textColor】: 子组件文字颜色   【Color】\n"
//          "【splashColor】: 水波纹颜色   【Color】\n"
//          "【highlightColor】: 长按高亮色   【Color】\n"
//          "【highlightedBorderColor】: 高亮时框色   【Color】\n"
//          "【child】: 子组件   【Widget】\n"
//          "【padding】: 内边距   【EdgeInsetsGeometry】\n"
//          "【borderSide】: 边线   【BorderSide】\n"
//          "【onPressed】: 点击事件   【Function】",
//    }

class CustomOutlineButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlineButton(//边线按钮
      onPressed: () {},
      child: Text("OutlineButton"),
      padding: EdgeInsets.all(8),
      splashColor: Colors.green,
      highlightColor: Colors.orangeAccent,
      highlightedBorderColor: Colors.grey,
      textColor: Color(0xff000000),
      borderSide: BorderSide(color: Color(0xff0A66F8), width: 2),
    );
  }
}
