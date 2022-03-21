import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/30
/// contact me by email 1981462002@qq.com
/// 说明: 

//    {
//      "widgetId": 94,
//      "name": 'Flex垂直方向顺序',
//      "priority": 4,
//      "subtitle":
//          "【verticalDirection】 : 垂直方向顺序   【VerticalDirection】",
//    }
class VerticalDirectionFlex extends StatelessWidget {

  static TextStyle textStyle =
  TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

  final blueBox = Container(
    alignment: Alignment.center,
    color: Colors.blue,
    height: 20,
    width: 30,
    child: Text(
      '1',
      style: textStyle,
    ),
  );

  final redBox = Container(
    alignment: Alignment.center,
    color: Colors.red,
    height: 30,
    width: 40,
    child: Text(
      '2',
      style: textStyle,
    ),
  );

  final greenBox = Container(
    alignment: Alignment.center,
    color: Colors.green,
    height: 20,
    width: 20,
    child: Text(
      '3',
      style: textStyle,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Wrap(
        runSpacing: 5,
        children: VerticalDirection.values
            .map((mode) => Column(children: <Widget>[
          Container(
              margin: EdgeInsets.all(5),
              width: 160,
              height: 80,
              color: Colors.grey.withAlpha(33),
              child: _buildItem(mode)),
          Text(mode.toString().split('.')[1])
        ]))
            .toList());
  }

  _buildItem(mode) => Flex(
    direction: Axis.vertical,
    verticalDirection: mode,
    children: <Widget>[
      blueBox, redBox, greenBox
    ],
  );
}
