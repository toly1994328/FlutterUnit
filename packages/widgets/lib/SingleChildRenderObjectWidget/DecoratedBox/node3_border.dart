import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/30
/// contact me by email 1981462002@qq.com
/// 说明: 
//    {
//      "widgetId": 70,
//      "name": 'DecoratedBox边线装饰',
//      "priority": 3,
//      "subtitle": "【border】 : 边线   【BoxBorder】\n",
//    }
class BorderDemo extends StatelessWidget {
  const BorderDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      position: DecorationPosition.foreground,
      decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(color: Colors.orange, width: 2),
            top: BorderSide(color: Colors.orange, width: 2)),
      ),
      child: SizedBox(
        height: 80,
        width: 100,
        child: Image.asset(
          'assets/images/wy_200x300.webp',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}