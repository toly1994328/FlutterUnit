import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 38,
//      "name": '图片重复模式',
//      "priority": 5,
//      "subtitle":
//          "【repeat】 : 重复模式*4   【ImageRepeat】",
//    },

class RepeatImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: ImageRepeat.values
          .toList()
          .map((mode) => Column(children: <Widget>[
        Container(
            margin: EdgeInsets.all(5),
            width: 150,
            height: 60,
            color: Colors.red,
            child: Image(
                image: AssetImage("assets/images/wy_30x20.webp"),
                repeat: mode)),
        Text(mode.toString().split(".")[1])
      ]))
          .toList(),
    );
  }
}