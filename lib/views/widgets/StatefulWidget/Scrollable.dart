//import 'package:flutter/material.dart';
//
///// create by 张风捷特烈 on 2020-03-28
///// contact me by email 1981462002@qq.com
///// 说明:
//
//class CustomScrollable extends StatelessWidget {
//  final data = <Color>[
//    Colors.blue[50],
//    Colors.blue[100],
//    Colors.blue[200],
//    Colors.blue[300],
//    Colors.blue[400],
//    Colors.blue[500],
//    Colors.blue[600],
//    Colors.blue[700],
//    Colors.blue[800],
//    Colors.blue[900],
//  ];
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      height: 200,
//      child: Scrollable(
//        viewportBuilder: (ctx, p) => Viewport(offset: p,
//        slivers: <Widget>[
//
//        ],
//        ),
//      ),
//    );
//  }
//
//  Column buildColumn() {
//    return Column(
//      children: data
//          .map((color) => Container(
//                alignment: Alignment.center,
//                height: 50,
//                color: color,
//                child: Text(
//                  colorString(color),
//                  style: TextStyle(color: Colors.white, shadows: [
//                    Shadow(
//                        color: Colors.black,
//                        offset: Offset(.5, .5),
//                        blurRadius: 2)
//                  ]),
//                ),
//              ))
//          .toList(),
//    );
//  }
//
//  String colorString(Color color) =>
//      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
//}
