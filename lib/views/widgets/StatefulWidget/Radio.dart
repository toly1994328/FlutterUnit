import 'package:flutter/material.dart';
//    {
//      "widgetId": 45,
//      "name": 'Radio基本使用',
//      "priority": 1,
//      "subtitle":
//          "【value】 : 选钮值   【T】\n"
//          "【groupValue】 : 当前匹配值   【T】\n"
//          "【activeColor】 : 激活颜色   【Color】\n"
//          "【onChanged】 : 改变时回调   【Function(T)】",
//    }
class CustomRadio extends StatefulWidget {
  @override
  _CustomRadioState createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  var data = <double>[1, 2, 3, 4, 5];
  double _value = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: data
          .map((e) => Radio<double>(
          activeColor: Colors.orangeAccent,
          value: e,
          groupValue: _value,
          onChanged: (v) => setState(() => _value = v)))
          .toList(),
    );
  }
}
