import 'package:flutter/material.dart';

//    {
//      "widgetId": 70,
//      "name": 'DecoratedBox基本使用',
//      "priority": 1,
//      "subtitle":
//          "【decoration】 : 装饰对象   【Decoration】\n"
//          "【decoration】 : 裁剪行为   【Clip】\n"
//          "【position】 : 前景色(左)/后景色(右)   【DecorationPosition】",
//    }
class CustomDecoratedBox extends StatelessWidget {
  final rainbow = <int>[
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
    return Wrap(
      spacing: 30,
      children: <Widget>[_buildDecoratedBox1(), _buildDecoratedBox2()],
    );
  }

  Widget _buildDecoratedBox2() {
    return DecoratedBox(
      position: DecorationPosition.foreground,
      decoration: BoxDecoration(
          border: Border(left: BorderSide(color: Colors.black, width: 2)),
          //添加渐变色
          gradient: LinearGradient(
              stops: <double>[0.0, 1 / 6, 2 / 6, 3 / 6, 4 / 6, 5 / 6, 1.0],
              colors: rainbow.map((e) => Color(e)).toList()),
          boxShadow: [
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

  Widget _buildDecoratedBox1() {
    return DecoratedBox(
      position: DecorationPosition.background,
      decoration: BoxDecoration(
          //添加渐变色
          gradient: LinearGradient(
              stops: <double>[0.0, 1 / 6, 2 / 6, 3 / 6, 4 / 6, 5 / 6, 1.0],
              colors: rainbow.map((e) => Color(e)).toList()),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), bottomRight: Radius.circular(40)),
          boxShadow: [
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
