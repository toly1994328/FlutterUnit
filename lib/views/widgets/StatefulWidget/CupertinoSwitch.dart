import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///    {
//      "widgetId": 41,
//      "name": 'CupertinoSwitch基本使用',
//      "priority": 1,
//      "subtitle":
//          "【value】 : 是否选中   【double】\n"
//          "【activeColor】 : 激活态颜色   【Color】\n"
//          "【onChanged】 : 切换回调   【Function(double)】",
//    }
class CustomCupertinoSwitch extends StatefulWidget {
  @override
  _CustomCupertinoSwitchState createState() => _CustomCupertinoSwitchState();
}

class _CustomCupertinoSwitchState extends State<CustomCupertinoSwitch> {
  final colors = [Colors.red, Colors.yellow, Colors.blue, Colors.green];

  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: colors
          .map((e) => CupertinoSwitch(
          value: _checked,
          activeColor: e,
          onChanged: (v) {
            setState(() => _checked = v);
          }))
          .toList(),
    );
  }
}
