import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-04-19
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 70,
//      "name": 'DecoratedBox基本使用',
//      "priority": 1,
//      "subtitle":
//          "【decoration】 : 装饰对象   【Decoration】\n"
//          "【position】 : 前景色(左)/后景色(右)   【DecorationPosition】",
//    }
class BoxDecorationDemo extends StatelessWidget {
  const BoxDecorationDemo({Key? key}) : super(key: key);

  final List<int> rainbow = const [
    0xffff0000,
    0xffFF7F00,
    0xffFFFF00,
    0xff00FF00,
    0xff00FFFF,
    0xff0000FF,
    0xff8B00FF
  ];

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      position: DecorationPosition.background,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              stops: const [0.0, 1 / 6, 2 / 6, 3 / 6, 4 / 6, 5 / 6, 1.0],
              colors: rainbow.map((e) => Color(e)).toList()),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          boxShadow: const [
            BoxShadow(
                color: Colors.orangeAccent,
                offset: Offset(1, 1),
                blurRadius: 10,
                spreadRadius: 1),
          ]),
      child: Icon(
        Icons.android,
        size: 80,
        color: Colors.black.withAlpha(123),
      ),
    );
  }
}
