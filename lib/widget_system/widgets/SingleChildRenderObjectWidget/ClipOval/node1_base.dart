import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-19
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 66,
//      "name": 'ClipOval基本使用',
//      "priority": 1,
//      "subtitle": "【child】 : 子组件   【Widget】\n"
//          "【clipBehavior】 : 裁剪行为   【Clip】\n"
//          "【clipper】 : 裁剪器   【CustomClipper<RRect>】",
//    }
class CustomClipOval extends StatelessWidget {
  const CustomClipOval({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      children: <Widget>[
        ClipOval(
          child: Image.asset(
            "assets/images/wy_300x200.webp",
            width: 150,
            height: 100,
          ),
        ),
        ClipOval(
          child: Image.asset(
            "assets/images/wy_300x200.webp",
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}