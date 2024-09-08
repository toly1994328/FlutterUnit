import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-04-19
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 67,
//      "name": 'ClipRect基本使用',
//      "priority": 1,
//      "subtitle": "【child】 : 子组件   【Widget】\n"
//          "【clipBehavior】 : 裁剪行为   【Clip】\n"
//          "【clipper】 : 裁剪器   【CustomClipper<Rect>】",
//    }
class CustomClipRect extends StatelessWidget {
  const CustomClipRect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SizedBox(
        height: 100,
        width: 100,
        child: Image.asset(
          "assets/images/wy_300x200.webp",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
