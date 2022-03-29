import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/6/30
/// contact me by email 1981462002@qq.com
/// 说明:
///
//    {
//      "widgetId": 262,
//      "name": 'CupertinoSegmentedControl的颜色',
//      "priority": 2,
//      "subtitle":
//          "【unselectedColor】 : 未选中色   【Color】\n"
//          "【selectedColor】 : 选中色   【Color<T>】\n"
//          "【pressedColor】 : 按下色   【Color】\n"
//          "【borderColor】 : 边线色   【Color】",
//    }
class CupertinoSegmentedControlColor extends StatefulWidget {
  const CupertinoSegmentedControlColor({Key? key}) : super(key: key);

  @override
  _CupertinoSegmentedControlColorState createState() =>
      _CupertinoSegmentedControlColorState();
}

class _CupertinoSegmentedControlColorState
    extends State<CupertinoSegmentedControlColor> {
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return CupertinoSegmentedControl<int>(
      unselectedColor: Colors.yellow,
      selectedColor: Colors.green,
      pressedColor: Colors.blue,
      borderColor: Colors.red,
      groupValue: _value,
      onValueChanged: _onValueChanged,
      padding: const EdgeInsets.only(top: 20),
      children: const {
        1: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Text("混沌战士"),
        ),
        2: Text("青眼白龙"),
        3: Text("黑魔术士"),
      },
    );
  }

  void _onValueChanged(int value) {
    setState(() {
      _value=value;
    });
  }
}
