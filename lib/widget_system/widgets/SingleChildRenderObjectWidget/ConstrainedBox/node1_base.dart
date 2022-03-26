import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-04-19
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 80,
//      "name": 'BoxConstraints基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子组件   【Widget】\n"
//          "【minWidth】 : 最小宽   【double】\n"
//          "【minHeight】 : 最小高   【double】\n"
//          "【maxHeight】 : 最大高   【double】\n"
//          "【maxWidth】 : 最大宽   【double】",
//    }
class CustomConstrainedBox extends StatefulWidget {
  const CustomConstrainedBox({Key? key}) : super(key: key);

  @override
  _CustomConstrainedBoxState createState() => _CustomConstrainedBoxState();
}

class _CustomConstrainedBoxState extends State<CustomConstrainedBox> {
  String _text = '';

  @override
  Widget build(BuildContext context) {
    Widget child = Container(
      alignment: Alignment.center,
      color: Colors.cyanAccent,
      width: 40,
      height: 40,
      child: const Text("Static"),
    );

    Widget box = ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 50,
        minWidth: 20,
        maxHeight: 80,
        maxWidth: 150,
      ),
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
        _buildInput(),
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
