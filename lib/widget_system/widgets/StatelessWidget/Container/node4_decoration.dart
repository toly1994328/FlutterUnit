import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 1,
//      "name": '可对子组件进行装饰',
//      "priority": 4,
//      "subtitle":
//          "【decoration】 : 装饰   【Decoration】\n "
//              "可装饰: 边线、圆弧、颜色、渐变色、阴影、图片等内容",
//    }
class ContainerDecoration extends StatelessWidget {
  ContainerDecoration({Key? key}) : super(key: key);

  final List<int> rainbow = [
    0xffff0000,
    0xffFF7F00,
    0xffFFFF00,
    0xff00FF00,
    0xff00FFFF,
    0xff0000FF,
    0xff8B00FF
  ];

 final List<double> stops = [0.0, 1 / 6, 2 / 6, 3 / 6, 4 / 6, 5 / 6, 1.0];

  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
      width: 200,
      height: 200 * 0.618,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(//添加渐变色
          gradient: LinearGradient(
              stops: stops,
              colors: rainbow.map((e) => Color(e)).toList()),
          borderRadius: const BorderRadius.only(
              topLeft:  Radius.circular(50),
              bottomRight:  Radius.circular(50)),
          boxShadow: const [
             BoxShadow(
                color: Colors.grey,
                offset:  Offset(1, 1),
                blurRadius: 10,
                spreadRadius: 1),
          ]),
      child: const Text(
        "Container",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}