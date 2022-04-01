import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-04-19
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 79,
//      "name": 'LimitedBox基本使用',
//      "priority": 1,
//      "subtitle": "【child】 : 孩子组件   【Widget】\n"
//          "【maxHeight】 : 最大高   【double】\n"
//          "【maxWidth】 : 最大宽   【double】",
//    }
class CustomLimitedBox extends StatefulWidget {
  const CustomLimitedBox({Key? key}) : super(key: key);

  @override
  _CustomLimitedBoxState createState() => _CustomLimitedBoxState();
}

class _CustomLimitedBoxState extends State<CustomLimitedBox> {
  String _text = '';

  @override
  Widget build(BuildContext context) {
    Widget child = Container(
      alignment: Alignment.center,
      color: Colors.cyanAccent,
      width: 50,
      height: 50,
      child: const Text("Static"),
    );

    Widget box = LimitedBox(
      maxHeight: 60,
      maxWidth: 100,
      child: Container(color: Colors.orange, child: Text(_text)),
    );

    return Column(
      children: <Widget>[
        Container(
          color: Colors.grey.withAlpha(22),
          width: 300,
          height: 100,
          child: Row(
            children: <Widget>[child, UnconstrainedBox(child: box), child],
          ),
        ),
        _buildInput()
      ],
    );
  }

  Widget _buildInput() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: '请输入',
        ),
        onChanged: (v) {
          setState(() {
            _text = v;
          });
        },
      ),
    );
  }
}
