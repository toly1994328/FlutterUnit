import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-31
/// contact me by email 1981462002@qq.com
/// 说明: 
//    {
//      "widgetId": 195,
//      "name": 'CupertinoScrollbar基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 子组件   【Widget】\n"
//          "【controller】 : 控制器  【ScrollController】",
//    }
class CustomCupertinoScrollbar extends StatelessWidget {
  final data = <Color>[
    Colors.purple[50],
    Colors.purple[100],
    Colors.purple[200],
    Colors.purple[300],
    Colors.purple[400],
    Colors.purple[500],
    Colors.purple[600],
    Colors.purple[700],
    Colors.purple[800],
    Colors.purple[900],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: CupertinoScrollbar(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 5),
          children: data
              .map((color) => Container(
            alignment: Alignment.center,
            width: 100,
            height: 50,
            color: color,
            child: Text(
              colorString(color),
              style: TextStyle(color: Colors.white, shadows: [
                Shadow(
                    color: Colors.black,
                    offset: Offset(.5, .5),
                    blurRadius: 2)
              ]),
            ),
          ))
              .toList(),
        ),
      ),
    );
  }

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}