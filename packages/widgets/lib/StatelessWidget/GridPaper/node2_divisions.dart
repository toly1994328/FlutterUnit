import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/27
/// contact me by email 1981462002@qq.com
/// 说明:
//     {
//      "widgetId": 37,
//      "priority": 2,
//      "name": "GridPager 再分割",
//      "subtitle": "【child】: 子组件   【Widget】\n"
//          "【color】: 颜色   【Color】\n"
//          "【subdivisions】: 小块中子块个数   【int】\n"
//          "【divisions】: 小块中子块的分割数   【int】",
//      }
class DivisionsGridPaper extends StatelessWidget {
  const DivisionsGridPaper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        height: 100,
        child: GridPaper(
            color: Colors.red,
            interval: 50,
            divisions: 4,
            subdivisions: 4,
            child: Image.asset(
              "assets/images/wy_300x200.webp",
              fit: BoxFit.cover,
            )));
  }
}
