import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-16
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 55,
//      "name": 'DropdownButton基本用法',
//      "priority": 1,
//      "subtitle":
//      "【value】 : 当前值   【T】\n"
//      "【items】 : 下拉选框   【List<DropdownMenuItem<T>>】\n"
//          "【icon】 : 图标   【Widget】\n"
//          "【elevation】 : 影深   【double】\n"
//          "【onChanged】 : 选择条目事件   【Function(T)】\n"
//          "【backgroundColor】 : 背景色   【Color】",
//    }
class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton({Key? key}) : super(key: key);

  @override
  _CustomDropDownButtonState createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  Color _color = Colors.red;
  final List<Color> _colors = const [
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.green
  ];
  final List<String> _info = const ["红色", "黄色", "蓝色", "绿色"];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: 50,
          height: 50,
          color: _color,
        ),
        DropdownButton<Color>(
            value: _color,
            elevation: 1,
            icon: Icon(
              Icons.expand_more,
              size: 20,
              color: _color,
            ),
            items: _buildItems(),
            onChanged: (v) => setState(() => _color = v??Colors.blue)),
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