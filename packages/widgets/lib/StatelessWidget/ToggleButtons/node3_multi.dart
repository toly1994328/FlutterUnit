
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/27
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 33,
//      "priority": 3,
//      "name": "ToggleButtons多选切换",
//      "subtitle": "    可以控制状态转化的逻辑来形成不同的效果。",
//    }
class ProToggleButtons extends StatefulWidget {
  const ProToggleButtons({Key? key}) : super(key: key);

  @override
  _ProToggleButtonsState createState() => _ProToggleButtonsState();
}

class _ProToggleButtonsState extends State<ProToggleButtons> {
  final List<bool> _isSelected = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      children: const <Widget>[
        Icon(Icons.skip_previous),
        Icon(Icons.pause),
        Icon(Icons.skip_next),
      ],
      borderWidth: 1,
      borderColor: Colors.blue,
      selectedBorderColor: Colors.orangeAccent,
      splashColor: Colors.purple.withAlpha(66),
      borderRadius: BorderRadius.circular(10),
      selectedColor: Colors.red,
      fillColor: Colors.green.withAlpha(11),
      isSelected: _isSelected,
      onPressed: (value) => setState(() {
        _isSelected[value] = !_isSelected[value];
      }),
    );
  }
}