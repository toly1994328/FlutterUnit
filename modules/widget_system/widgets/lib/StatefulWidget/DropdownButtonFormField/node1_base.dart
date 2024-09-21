import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com


class DropdownButtonFormFieldDemo extends StatefulWidget {
  const DropdownButtonFormFieldDemo({Key? key}) : super(key: key);

  @override
  _DropdownButtonFormFieldDemoState createState() =>
      _DropdownButtonFormFieldDemoState();
}

class _DropdownButtonFormFieldDemoState extends State<DropdownButtonFormFieldDemo> {
  Color _color = Colors.blue;
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

        SizedBox(
          width: 80,
          child: DropdownButtonFormField<Color>(
              value: _color,
              elevation: 1,
              hint: const Text('选择颜色',style: TextStyle(fontSize: 12),),
              icon: Icon(
                Icons.expand_more,
                size: 20,
                color: _color,
              ),
            items: _buildItems(),
              onChanged: (v) => setState(() => _color = v ?? Colors.blue)),
        )

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