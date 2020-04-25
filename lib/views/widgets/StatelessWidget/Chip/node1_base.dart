

/// create by 张风捷特烈 on 2020/4/25
/// contact me by email 1981462002@qq.com
/// 说明: 

//    {
//      "widgetId": 11,
//      "priority": 1,
//      "name": "Chip的普通表现如下",
//      "subtitle": "【avatar】: 左侧组件   【Widget】\n"
//          "【label】: 中间组件   【Widget】\n"
//          "【padding】 : 内边距  【EdgeInsetsGeometry】\n"
//          "【labelPadding】: label边距   【EdgeInsetsGeometry】",
//    }

import 'package:flutter/material.dart';
class CustomChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      children: <Widget>[
        Chip(
          avatar: Image.asset("assets/images/icon_head.png"),
          label: Text("张风捷特烈"),
          padding: EdgeInsets.all(5),
          labelPadding: EdgeInsets.all(5),
        ),
        Chip(
          avatar: CircleAvatar(
              backgroundImage:
              AssetImage("assets/images/wy_200x300.jpg")),
          label: Text("百里巫缨"),
          padding: EdgeInsets.all(8),
          labelPadding: EdgeInsets.all(6),
        ),
      ],
    );
  }
}