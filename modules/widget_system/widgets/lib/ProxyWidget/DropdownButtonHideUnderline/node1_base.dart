import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-30
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 181,
//      "name": 'DropDownButtonHideUnderline使用',
//      "priority": 1,
//      "subtitle": "【child】 : 子组件   【Widget】\n",
//    }
class CustomDropDownButtonHideUnderline extends StatefulWidget {
  const CustomDropDownButtonHideUnderline({Key? key}) : super(key: key);

  @override
  _CustomDropDownButtonHideUnderlineState createState() =>
      _CustomDropDownButtonHideUnderlineState();
}

class _CustomDropDownButtonHideUnderlineState
    extends State<CustomDropDownButtonHideUnderline> {
  Color _color = Colors.red;
  final List<Color> _colors = const[
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.green
  ];
  final List<String> _info = const["红色", "黄色", "蓝色", "绿色"];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: 50,
          height: 50,
          color: _color,
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton<Color>(
              value: _color,
              elevation: 1,
              icon: Icon(
                Icons.expand_more,
                size: 20,
                color: _color,
              ),
              items: _buildItems(),
              onChanged: (Color? color) =>
                  setState(() => _color = color ?? _color)),
        ),
      ],
    );
  }

  List<DropdownMenuItem<Color>> _buildItems() => _colors
      .map((e) => DropdownMenuItem<Color>(
          value: e,
          child: Text(
            _info[_colors.indexOf(e)],
            style: TextStyle(color: e),
          )))
      .toList();
}
