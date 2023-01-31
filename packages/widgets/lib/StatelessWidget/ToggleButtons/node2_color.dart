

import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/27
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 33,
//      "priority": 2,
//      "name": "ToggleButtons颜色属性",
//      "subtitle": "【borderColor】: 边线色   【Color】\n"
//          "【selectedBorderColor】: 选中边线色   【Color】\n"
//          "【selectedColor】: 选中时组件色   【Color】\n"
//          "【fillColor】: 选中时填充色   【Color】\n"
//          "【splashColor】: 水波纹色   【Color】",
//    }
class ColorToggleButtons extends StatefulWidget {
  const ColorToggleButtons({Key? key}) : super(key: key);

  @override
  _ColorToggleButtonsState createState() => _ColorToggleButtonsState();
}

class _ColorToggleButtonsState extends State<ColorToggleButtons> {
  List<bool> _isSelected = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      children: const <Widget>[
        Icon(Icons.skip_previous),
        Icon(Icons.pause),
        Icon(Icons.skip_next),
      ],
      borderWidth: 1,
      borderColor: Colors.orangeAccent,
      selectedBorderColor: Colors.blue,
      splashColor: Colors.purple.withAlpha(66),
      borderRadius: BorderRadius.circular(10),
      selectedColor: Colors.red,
      fillColor: Colors.green.withAlpha(11),
      isSelected: _isSelected,
      onPressed: (value) => setState(() {
        _isSelected = _isSelected.map((e) => false).toList();
        _isSelected[value] = true;
      }),
    );
  }
}
