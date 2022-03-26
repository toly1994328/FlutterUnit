import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/27
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 33,
//      "priority": 1,
//      "name": "ToggleButtons单选切换",
//      "subtitle": "【children】: 子组件集   【List<Widget>】\n"
//          "【borderWidth】: 边线宽   【double】\n"
//          "【borderRadius】: 圆角   【BorderRadius】\n"
//          "【isSelected】: 是否选中集   【List<bool>】\n"
//          "【onPressed】: 点击事件   【Function(int)】",
//    }
class CustomToggleButtons extends StatefulWidget {
  const CustomToggleButtons({Key? key}) : super(key: key);

  @override
  _CustomToggleButtonsState createState() => _CustomToggleButtonsState();
}

class _CustomToggleButtonsState extends State<CustomToggleButtons> {
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
      borderRadius: BorderRadius.circular(10),
      isSelected: _isSelected,
      onPressed: (value) => setState(() {
        _isSelected = _isSelected.map((e) => false).toList();
        _isSelected[value] = true;
      }),
    );
  }
}