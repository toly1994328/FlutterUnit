import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-04-19
/// contact me by email 1981462002@qq.com

class CustomOverflowBox extends StatefulWidget {
  const CustomOverflowBox({Key? key}) : super(key: key);

  @override
  _CustomOverflowBoxState createState() => _CustomOverflowBoxState();
}

class _CustomOverflowBoxState extends State<CustomOverflowBox> {
  String _text = '';

  @override
  Widget build(BuildContext context) {
    Widget box = OverflowBox(
      alignment: Alignment.center,
      minHeight: 50,
      minWidth: 50,
      maxWidth: 200,
      maxHeight: 120,
      child: Container(
        color: Colors.orange,
        child: Text(_text),
      ),
    );
    return Column(
      children: <Widget>[
        Container(
            color: Colors.grey.withAlpha(33),
            width: 100,
            height: 100,
            child: box),
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
