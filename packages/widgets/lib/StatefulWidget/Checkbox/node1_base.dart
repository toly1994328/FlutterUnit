
import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 39,
//      "name": 'Checkbox基础用法',
//      "priority": 1,
//      "subtitle":
//          "【value】 : 是否选中   【double】\n"
//          "【checkColor】: 选中时✔️gou颜色 【Color】\n"
//          "【activeColor】: 选中时框内颜色 【Color】\n"
//          "【onChanged】: 状态改变事件 【Function(bool)】\n",
//    }

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({Key? key}) : super(key: key);

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool _checked = false;
  final List<Color> colors = [
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.green
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: colors
          .map((e) => Checkbox(
              value: _checked,
              checkColor: Colors.white,
              activeColor: e,
              onChanged: (bool? value) =>
                  setState(() => _checked = value??false)))
          .toList(),
    );
  }
}


