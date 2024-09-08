import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2023/01/27
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 258,
//      "name": 'Badge 圆点标记的使用',
//      "priority": 1,
//      "subtitle": "【backgroundColor】 : 背景色   【Color?】\n"
//          "【isLabelVisible】 : 是否显示标记  【bool】\n"
//          "【smallSize】 : 无标签时直径   【double?】\n"
//          "【child】 : 子组件   【Widget?】",
//    }

class BadgeDemo extends StatelessWidget {
  const BadgeDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 20,
      children: [
        Badge(
          backgroundColor: Colors.redAccent,
          smallSize: 10,
          child: Icon(Icons.update,size: 36,color: Colors.green,),
        ),
        Badge(
          backgroundColor: Colors.redAccent,
          smallSize: 10,
          isLabelVisible: false,
          child: Icon(Icons.update,size: 36,color: Colors.green,),
        ),
      ],
    );
  }
}

