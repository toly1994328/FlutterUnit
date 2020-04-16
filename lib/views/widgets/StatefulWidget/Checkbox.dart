
import 'package:flutter/material.dart';

//    {
//      "widgetId": 39,
//      "name": 'Checkbox基础用法',
//      "priority": 1,
//      "subtitle":
//          "【value】 : 是否选中   【double】\n"
//          "【checkColor】: 选中时✔️gou颜色 【Color】\n"
//          "【activeColor】: 选中时框内颜色 【Color】\n"
//          "【onChanged】: 状态改变事件 【Function(bool)】\n"
//    }

class CustomCheckbox extends StatefulWidget {
  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool _checked = false;
  final colors = [Colors.red, Colors.yellow, Colors.blue, Colors.green];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: colors
          .map((e) =>
          Checkbox(
              value: _checked,
              checkColor: Colors.white,
              activeColor: e,
              onChanged: (v) =>
                  setState(() => _checked = v)))
          .toList(),
    );
  }
}


///    {
//      "widgetId": 39,
//      "name": 'Checkbox的三态',
//      "priority": 2,
//      "subtitle":
//          "【tristate】 : 是否是三态   【double】\n"
//          "  onChanged时,回调true、null、false三种状态"
//    }
class TristateCheckBok extends StatefulWidget {
  @override
  _TristateCheckBokState createState() => _TristateCheckBokState();
}

class _TristateCheckBokState extends State<TristateCheckBok> {
  bool _checked = false;
  final colors = [Colors.red, Colors.yellow, Colors.blue, Colors.green];
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: colors
          .map((e) =>
          Checkbox(
              value: _checked,
              tristate: true,
              checkColor: Colors.white,
              activeColor: e,
              onChanged: (v) {
                print(v);
                setState(() => _checked = v);
              }))
          .toList(),
    );
  }
}

