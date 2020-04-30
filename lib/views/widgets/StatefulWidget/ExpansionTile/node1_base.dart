import 'package:flutter/material.dart';
import 'package:flutter_unit/views/widgets/exp/stateless_unit.dart';

//    {
//      "widgetId": 52,
//      "name": 'ExpansionTile基本使用',
//      "priority": 1,
//      "subtitle":
//          "【children】 : 展开内容   【List<Widget>】\n"
//          "【leading】 : 头左组件   【Widget】\n"
//          "【title】 : 头中组件   【Widget】\n"
//          "【trailing】 : 头尾组件   【Widget】\n"
//          "【backgroundColor】 : 背景色   【Color】\n"
//          "【onExpansionChanged】 : 折叠事件   【Function(bool)】\n"
//          "【initiallyExpanded】 : 是否初始时展开   【bool】",
//    }
class CustomExpansionTile extends StatefulWidget {
  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(Icons.star),
      title: Text("选择语言"),
      backgroundColor: Colors.grey.withAlpha(6),
      onExpansionChanged: (value) {
        print('$value');
      },
      initiallyExpanded: false,
      children: <Widget>[CustomRadioListTile()],
    );
  }
}
