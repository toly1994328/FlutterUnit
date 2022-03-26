import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/27
/// contact me by email 1981462002@qq.com
/// 说明: 

//    {
//      "widgetId": 162,
//      "name": 'ListView横向滑动',
//      "priority": 2,
//      "subtitle":
//          "【scrollDirection】 : 滑动方向   【Axis】\n"
//          "【reverse】 : 是否反向滑动   【bool】\n"
//          "【shrinkWrap】 : 无边界时是否包裹  【bool】",
//    }
class HorizontalListView extends StatelessWidget {
  HorizontalListView({Key? key}) : super(key: key);

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

  TextStyle get textStyle => const TextStyle(
    color: Colors.white,
    shadows: [
      Shadow(color: Colors.black, offset: Offset(.5, .5), blurRadius: 2)
    ],
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView(
        reverse: true,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: data
            .map((color) => Container(
          alignment: Alignment.center,
          width: 100,
          height: 50,
          color: color,
          child: Text(
            colorString(color),
            style: textStyle,
          ),
        ))
            .toList(),
      ),
    );
  }

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}