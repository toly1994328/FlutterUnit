import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 1,
//      "name": '可用于显示一个指定宽高的区域',
//      "priority": 1,
//      "subtitle": "【width】 : 宽   【int】\n"
//          "【height】: 高   【int】\n"
//          "【color】: 颜色    【Color】",
//    }
class CustomContainer extends StatelessWidget {
  const CustomContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: 200,
      height: 200 * 0.618,
      color: Colors.red.withAlpha(88),
    );
  }
}