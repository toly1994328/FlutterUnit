import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com

class CupertinoTextFieldDemo extends StatefulWidget {
  const CupertinoTextFieldDemo({Key? key}) : super(key: key);

  @override
  _CupertinoTextFieldDemoState createState() => _CupertinoTextFieldDemoState();
}

class _CupertinoTextFieldDemoState extends State<CupertinoTextFieldDemo> {
  String _value = '';
  Color _color =Colors.black;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('输入了:$_value',style: TextStyle(color: _color),),
        CupertinoTextField(
          placeholder: 'Input Name',
          showCursor: true,
          minLines: 1,
          maxLines: 4,
          padding: const EdgeInsets.all(8),
          onChanged: _onChanged,
          onTap: _onTap,
          onSubmitted: _onSubmitted,
        ),
      ],
    );
  }

  void _onChanged(String value) {
    setState(() {
      _value = value;
    });
  }

  void _onTap() {
    print('----_onTap----');
    setState(() {
      _color=Colors.blue;
    });
  }

  void _onSubmitted(String value) {
    print('----_onSubmitted:$value}----');
    setState(() {
      _color=Colors.black;
    });
  }

}
