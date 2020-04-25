/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 25,
//      "priority": 1,
//      "name": "FlatButton点击事件",
//      "subtitle": "【color】: 颜色   【Color】\n"
//          "【splashColor】: 水波纹颜色   【Color】\n"
//          "【child】: 子组件   【Widget】\n"
//          "【textColor】: 子组件文字颜色   【Color】\n"
//          "【highlightColor】: 长按高亮色   【Color】\n"
//          "【padding】: 内边距   【EdgeInsetsGeometry】\n"
//          "【onPressed】: 点击事件   【Function】",
//    }

import 'package:flutter/material.dart';

class CustomFlatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: ()=>{},
      padding: EdgeInsets.all(8),
      splashColor: Colors.green,
      child: Text("FlatButton"),
      textColor: Color(0xffFfffff),
      color: Colors.blue,
      highlightColor: Color(0xffF88B0A),
    );
  }
}
