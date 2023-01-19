import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-30
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 97,
//      "name": 'Stack和Positioned结合使用',
//      "priority": 2,
//      "subtitle":
//          "Positioned组件只能用与Stack中，可以指定左上右下的距离对某个组件进行位置精确安放。",
//    }
class PositionedStack extends StatelessWidget {
  const PositionedStack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget yellowBox = Container(
      color: Colors.yellow,
      height: 100,
      width: 100,
    );

    Widget redBox = Container(
      color: Colors.red,
      height: 90,
      width: 90,
    );

    Widget greenBox = Container(
      color: Colors.green,
      height: 80,
      width: 80,
    );

    Widget cyanBox = Container(
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
