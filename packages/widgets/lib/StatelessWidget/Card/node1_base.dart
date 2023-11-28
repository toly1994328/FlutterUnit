

import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/25
/// contact me by email 1981462002@qq.com
/// 说明:
///
//    {
//      "widgetId": 3,
//      "priority": 1,
//      "name": "Card可以让一个组件卡片化",
//      "subtitle": "【elevation】 : 影深  【double】\n"
//          "【margin】: 外边距   【double】\n"
//          "【color】: 颜色   【Color】\n"
//          "【child】: 孩子   【Widget】",
//    }
class CustomCard extends StatelessWidget {
  const CustomCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffB3FE65),
      elevation: 4,
      margin: const EdgeInsets.all(10),
      child: Container(
        alignment: Alignment.topLeft,
        width: 200,
        height: 0.618*200,
        margin: const EdgeInsets.all(10),
        child: const Text("Card", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}