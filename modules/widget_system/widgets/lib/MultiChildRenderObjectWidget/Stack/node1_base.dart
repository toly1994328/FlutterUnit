import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-30
/// contact me by email 1981462002@qq.com
/// 说明:
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
  const CustomStack({Key? key}) : super(key: key);

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
        textDirection: TextDirection.rtl,
        fit: StackFit.loose,
        alignment: Alignment.topRight,
        // overflow: Overflow.clip, // 1.22.0 被去除
        children: <Widget>[yellowBox, redBox, greenBox, cyanBox],
      ),
    );
  }
}