import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com
/// 说明: 208 Title 0 该组件用于描述app在操作系统中的名称,可以在应用栏列表里看到效果。MaterialApp中的title字段效果的根源是该组件。
//    {
//      "widgetId": 208,
//      "name": "Title基本使用",
//      "priority": 1,
//      "subtitle": "【title】 : 名称   【int】\n"
//          "【color】: 颜色   【Color】\n"
//          "【child】: 子组件    【Widget】",
//    }
class TitleDemo extends StatelessWidget {
  const TitleDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Title(
      title: '张风捷特烈',
      color: const Color(0xFF9C27B0),
      child: const Center(
        child: Text('应用菜单栏中该页的名称为: 张风捷特烈'),
      ),
    );
  }
}
