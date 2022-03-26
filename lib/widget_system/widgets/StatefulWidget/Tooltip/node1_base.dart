import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-04-01
/// contact me by email 1981462002@qq.com
/// 说明:
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
//          "【child】 : 孩子   【Widget】",
//    }
class CustomTooltip extends StatelessWidget {
  const CustomTooltip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Tooltip(
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
