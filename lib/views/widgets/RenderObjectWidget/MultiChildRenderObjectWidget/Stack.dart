import 'package:flutter/material.dart';

//    {
//      "widgetId": 97,
//      "name": 'Stack基本使用',
//      "priority": 1,
//      "subtitle":
//          "【children】 : 组件列表   【List<Widget>】\n"
//          "【textDirection】 : 孩子排布方向   【MainAxisAlignment】\n"
//          "【alignment】 : 对齐方式   【AlignmentGeometry】\n"
//          "【overflow】 : 溢出模式   【Overflow】\n"
//          "【fit】 : 适应模式   【StackFit】",
//    }
class CustomStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var yellowBox = Container(
      color: Colors.yellow,
      height: 100,
      width: 100,
    );

    var redBox = Container(
      color: Colors.red,
      height: 90,
      width: 90,
    );

    var greenBox = Container(
      color: Colors.green,
      height: 80,
      width: 80,
    );

    var cyanBox = Container(
      color: Colors.cyanAccent,
      height: 70,
      width: 70,
    );

    return Container(
      width: 200,
      height: 120,
      color: Colors.grey.withAlpha(33),
      child: Stack(
        textDirection: TextDirection.rtl,
        fit: StackFit.loose,
        alignment: Alignment.topRight,
        overflow: Overflow.clip,
        children: <Widget>[yellowBox, redBox, greenBox, cyanBox],
      ),
    );
  }
}

//    {
//      "widgetId": 97,
//      "name": 'Stack和Positioned结合使用',
//      "priority": 2,
//      "subtitle":
//          "Positioned组件只能用与Stack中，可以指定左上右下的距离对某个组件进行位置精确安放。",
//    }
class PositionedStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var yellowBox = Container(
      color: Colors.yellow,
      height: 100,
      width: 100,
    );

    var redBox = Container(
      color: Colors.red,
      height: 90,
      width: 90,
    );

    var greenBox = Container(
      color: Colors.green,
      height: 80,
      width: 80,
    );

    var cyanBox = Container(
      color: Colors.cyanAccent,
      height: 70,
      width: 70,
    );

    return Container(
        width: 200,
        height: 120,
        color: Colors.grey.withAlpha(33),
        child: Stack(
          children: <Widget>[yellowBox, redBox, greenBox,
            Positioned(
              child: cyanBox,
              bottom: 10,
              right: 10,
            )
          ],
        ));
  }
}
