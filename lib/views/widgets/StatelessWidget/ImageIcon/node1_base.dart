import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/27
/// contact me by email 1981462002@qq.com
/// 说明:
//      {
//      "widgetId": 7,
//      "priority": 1,
//      "name": "用于显示一个纯色图片",
//      "subtitle": "【入参】 : 图片资源  【ImageProvider】\n"
//          "【size】 : 大小  【double】\n"
//          "【color】: 角标颜色   【Color】",
//      }

class CustomImageIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = {
      Colors.blue: 50.0,
      Colors.red: 60.0,
      Colors.green: 70.0,
      Colors.yellow: 80.0,
    };
    return Wrap(
      spacing: 10,
      children: data.keys
          .map((e) => ImageIcon(
                AssetImage("assets/images/leaf.png"),
                color: e,
                size: data[e],
              ))
          .toList(),
    );
  }
}
