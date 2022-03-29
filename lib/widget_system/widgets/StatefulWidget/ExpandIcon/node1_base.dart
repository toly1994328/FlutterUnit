import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-16
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 51,
//      "name": 'ExpandIcon基本使用',
//      "priority": 1,
//      "subtitle":
//          "【isExpanded】 : 是否展开   【bool】\n"
//          "【padding】 : 内边距   【EdgeInsetsGeometry】\n",
//          "【size】 : 图标大小   【double】\n"
//          "【color】 : 不展开时颜色   【Color】\n"
//          "【expandedColor】 : 展开时颜色   【Color】\n"
//          "【onPressed】 : 点击事件   【Function(bool)】",
//    }
class CustomExpandIcon extends StatefulWidget {
  const CustomExpandIcon({Key? key}) : super(key: key);

  @override
  _CustomExpandIconState createState() => _CustomExpandIconState();
}

class _CustomExpandIconState extends State<CustomExpandIcon> {
  bool _closed = true;

  @override
  Widget build(BuildContext context) {
    return ExpandIcon(
      isExpanded: _closed,
      padding: const EdgeInsets.all(5),
      size: 30,
      color: Colors.blue,
      expandedColor: Colors.orangeAccent,
      onPressed: (value) => setState(() => _closed = !_closed),
    );
  }
}
