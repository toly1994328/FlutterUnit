import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-22
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 26,
//      "priority": 1,
//      "name": "RaisedButton点击事件",
//      "subtitle": "【color】: 颜色   【Color】\n"
//          "【splashColor】: 水波纹颜色   【Color】\n"
//          "【elevation】: 影深   【double】\n"
//          "【child】: 子组件   【Widget】\n"
//          "【textColor】: 子组件文字颜色   【Color】\n"
//          "【highlightColor】: 长按高亮色   【Color】\n"
//          "【padding】: 内边距   【EdgeInsetsGeometry】\n"
//          "【onPressed】: 点击事件   【Function】",
//    }

class CustomRaisedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.blue,
      splashColor: Colors.green,
      onPressed: () {},
      child: Text("RaisedButton"),
      textColor: Color(0xffFfffff),
      padding: EdgeInsets.all(8),
      elevation: 5,
      highlightColor: Color(0xffF88B0A),
    );
  }
}
