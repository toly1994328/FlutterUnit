import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/27
/// contact me by email 1981462002@qq.com
/// 说明: 

//    {
//      "widgetId": 162,
//      "name": 'ListView.builder构造',
//      "priority": 3,
//      "subtitle":
//          "【itemCount】 : 条目个数   【int】\n"
//          "【itemBuilder】 : 条目构造器   【IndexedWidgetBuilder】",
//    }
class BuilderListView extends StatelessWidget {
  BuilderListView({Key? key}) : super(key: key);

  final List<Color> data = [
    Colors.purple[50]!,
    Colors.purple[100]!,
    Colors.purple[200]!,
    Colors.purple[300]!,
    Colors.purple[400]!,
    Colors.purple[500]!,
    Colors.purple[600]!,
    Colors.purple[700]!,
    Colors.purple[800]!,
    Colors.purple[900]!,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) => _buildItem(data[index]),
      ),
    );
  }

  TextStyle get textStyle => const TextStyle(
        color: Colors.white,
        shadows: [
          Shadow(color: Colors.black, offset: Offset(.5, .5), blurRadius: 2)
        ],
      );

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";

  Widget _buildItem(Color color) => Container(
        alignment: Alignment.center,
        width: 100,
        height: 50,
        color: color,
        child: Text(
          colorString(color),
          style: textStyle,
        ),
      );
}