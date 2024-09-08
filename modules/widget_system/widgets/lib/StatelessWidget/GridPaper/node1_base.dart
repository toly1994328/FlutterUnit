import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/27
/// contact me by email 1981462002@qq.com
/// 说明: 

//     {
//      "widgetId": 37,
//      "priority": 1,
//      "name": "GridPager 基础属性",
//      "subtitle": "【child】: 子组件   【Widget】\n"
//          "【color】: 颜色   【Color】\n"
//          "【interval】: 小块边长   【double】",
//      }
class CustomGridPaper extends StatelessWidget {
  const CustomGridPaper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        height: 100,
        child: GridPaper(
            color: Colors.red,
            interval: 50,
            child: Image.asset(
              "assets/images/wy_300x200.webp",
              fit: BoxFit.cover,
            )));
  }
}