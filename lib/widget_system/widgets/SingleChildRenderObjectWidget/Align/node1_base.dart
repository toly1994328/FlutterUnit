
import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-04-19
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 85,
//      "name": 'Align基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子组件   【Widget】\n"
//          "【alignment】 : 对齐方式   【AlignmentGeometry】",
//    }
class CustomAlign extends StatelessWidget {
  const CustomAlign({Key? key}) : super(key: key);

  final List<Alignment> alignments = const [
    Alignment.topLeft,
    Alignment.topCenter,
    Alignment.topRight,
    Alignment.centerLeft,
    Alignment.center,
    Alignment.centerRight,
    Alignment.bottomLeft,
    Alignment.bottomCenter,
    Alignment.bottomRight,
  ];

  final List<String> alignmentsInfo = const [
    "topLeft",
    "topCenter",
    "topRight",
    "centerLeft",
    "center",
    "centerRight",
    "bottomLeft",
    "bottomCenter",
    "bottomRight",
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: alignments
            .toList()
            .map((mode) => Column(children: <Widget>[
                  Container(
                      margin: const EdgeInsets.all(5),
                      width: 100,
                      height: 60,
                      color: Colors.grey.withAlpha(88),
                      child: Align(
                          child: Container(
                            width: 30,
                            height: 30,
                            color: Colors.cyanAccent,
                          ),
                          alignment: mode)),
                  Text(alignmentsInfo[alignments.indexOf(mode)])
                ]))
            .toList());
  }
}