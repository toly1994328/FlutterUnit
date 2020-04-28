import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-16
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 55,
//      "name": 'DropdownButton的样式指定',
//      "priority": 2,
//      "subtitle":
//      "【isDense】 : 是否紧排   【bool】\n"
//      "【iconSize】 : 图标大小   【double】\n"
//      "【hint】 : 提示组件   【Widget】\n"
//          "【iconEnabledColor】 : 图标颜色   【Color】",
//    }

class StyleDropDownButton extends StatefulWidget {
  @override
  _StyleDropDownButtonState createState() => _StyleDropDownButtonState();
}

class _StyleDropDownButtonState extends State<StyleDropDownButton> {
  Color _color = Colors.red ;
  final _colors = [Colors.red, Colors.yellow, Colors.blue, Colors.green];
  final _info = ["红色", "黄色", "蓝色", "绿色"];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: 50,
          height: 50,
          color: _color??Colors.transparent,
        ),
        DropdownButton<Color>(
            hint: Text('请选择'),
            isDense: true,
            iconSize:20,
            iconEnabledColor:_color??Colors.orange,
            value: _color,
            items: _buildItems(),
            onChanged: (v) => setState(() => _color = v)),
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
