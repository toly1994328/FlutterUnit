/// create by 张风捷特烈 on 2020/4/25
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 31,
//      "priority": 1,
//      "name": "BackButton属性",
//      "subtitle": "【color】: 颜色   【Color】\n"
//          "【onPressed】: 点击事件   【Function】\n"
//          "   onPressed为空会退出当前栈",
//    }

import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = [Colors.red,Colors.yellow,Colors.blue,Colors.green];
    return Wrap(
      spacing: 10,
      children: data.map((e)=>BackButton(
        color: e,
      )).toList()
    );
  }
}
