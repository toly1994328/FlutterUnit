/// create by 张风捷特烈 on 2020/4/25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 9,
//      "priority": 1,
//      "name": "CircleAvatar的表现",
//      "subtitle": "【radius】 : 半径  【double】\n"
//          "【backgroundImage】 : 图片资源  【ImageProvider】\n"
//          "【foregroundColor】: 前景色   【Color】\n"
//          "【backgroundColor】: 背景色   【Color】\n"
//          "【minRadius】: 最小半径   【double】\n"
//          "【maxRadius】: 最大半径   【double】\n"
//          "【child】: 孩子组件   【Child】",
//    }

import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 50,
      backgroundImage: AssetImage("assets/images/wy_200x300.webp"),
      foregroundColor: Colors.white,
      child: Icon(
        Icons.check,
        size: 50,
      ),
    );
  }
}
