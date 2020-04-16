import 'package:flutter/material.dart';

//    {
//      "widgetId": 50,
//      "name": 'Tooltip基本使用',
//      "priority": 1,
//      "subtitle":
//          "【preferBelow】 : 是否首选下方   【bool】\n"
//          "【padding】 : 内边距   【EdgeInsetsGeometry】\n"
//          "【margin】 : 外边距   【EdgeInsetsGeometry】\n"
//          "【message】 : 消息内容   【String】\n"
//          "【showDuration】 : 展示时间   【Duration】\n"
//          "【waitDuration】 : 悬浮出现时间   【Duration】\n"
//          "【child】 : 孩子   【Widget】"
//    }
class CustomTooltip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      preferBelow: true,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(5),
      message: "天王盖地虎",
      showDuration: Duration(seconds: 3),
      waitDuration: Duration(milliseconds: 200),
      child: Icon(Icons.info_outline),
    );
  }
}

//    {
//      "widgetId": 50,
//      "name": 'Tooltip的装饰',
//      "priority": 2,
//      "subtitle":
//          "【decoration】 : 装饰对象 【Decoration】\n"
//          "【textStyle】 : 文字样式   【double】"
//    }
class DecorationTooltip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
        preferBelow: false,
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(2),
        message: "宝塔镇河妖",
        textStyle: TextStyle(
            color: Colors.red,
            shadows: [Shadow(color: Colors.white,
                offset: Offset(1, 1))]),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.orangeAccent,
              offset: Offset(1, 1), blurRadius: 8)
        ]),
        child: Icon(Icons.info_outline));
  }
}
