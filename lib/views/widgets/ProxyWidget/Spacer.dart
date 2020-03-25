import 'package:flutter/material.dart';
import 'package:flutter_unit/app/utils/color_utils.dart';

/// create by 张风捷特烈 on 2020-03-22
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 107,
//      "name": 'Spacer基本使用',
//      "priority": 1,
//      "subtitle":
//          "【flex】 : 剩余空间分配占比   【int】",
//    }
class CustomSpacer extends StatefulWidget {
  @override
  _CustomSpacerState createState() => _CustomSpacerState();
}

class _CustomSpacerState extends State<CustomSpacer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          buildRow([1, 1, 1]),
          SizedBox(height: 10,),
          buildRow([1, 2, 1]),
          SizedBox(height: 10,),
          buildRow([2, 2, 1]),
        ],
      ),
    );
  }

  Widget buildRow(List<int> num) {
    return Row(
        children:[
          Spacer(flex: num[0]),
          Container(
            alignment: Alignment.center,
            width: 100,
            height: 50,
            color: ColorUtils.randomColor(),
          ),
          Spacer(flex: num[1]),
          Container(
            alignment: Alignment.center,
            width: 60,
            height: 50,
            color: ColorUtils.randomColor(),
          ),
          Spacer(flex: num[2]),
        ]
    );
  }
}
