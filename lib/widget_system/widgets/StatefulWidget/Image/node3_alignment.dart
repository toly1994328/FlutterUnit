import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 38,
//      "name": '图片对齐模式',
//      "priority": 3,
//      "subtitle":
//          "【alignment】 : 颜色   【AlignmentGeometry】\n"
//          "    常用Alignment类的九个静态常量，但也可定制位置",
//    },

class AlignmentImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var alignment = [
      Alignment.center,
      Alignment.centerLeft,
      Alignment.centerRight,
      Alignment.topCenter,
      Alignment.topLeft,
      Alignment.topRight,
      Alignment.bottomCenter,
      Alignment.bottomLeft,
      Alignment.bottomRight
    ]; //测试数组
    var imgLi = alignment
        .map((alignment) => //生成子Widget列表
    Column(children: <Widget>[
      Container(
          margin: EdgeInsets.all(5),
          width: 90,
          height: 60,
          color: Colors.grey.withAlpha(88),
          child: Image(
            image: AssetImage("assets/images/wy_30x20.webp"),
            alignment: alignment,
          )),
      Text(alignment.toString())
    ]))
        .toList();
    var imageAlignment = Wrap(children: imgLi);
    return imageAlignment;
  }
}