import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com
/// 说明: 245 CupertinoTextField 1 Cupertino风格的输入框,属性和TextField类似,可指定控制器、文字样式、装饰线、行数限制、游标样式等。接收输入变化、完成输入等事件。
//    {
//      "widgetId": 245,
//      "name": "CupertinoTextField基础使用",
//      "priority": 1,
//      "subtitle": "【placeholder】 : 提示文字   【String】\n"
//          "【showCursor】 : 是否显示游标   【bool】\n"
//          "【minLines】 : 最小行数   【int】\n"
//          "【maxLines】 : 最大行数   【int】\n"
//          "【padding】 : 内边距   【EdgeInsetsGeometry】\n"
//          "【onChanged】 : 变化监听   【ValueChanged<String>】\n"
//          "【onTap】: 点击监听   【GestureTapCallback】\n"
//          "【onSubmitted】: 提交监听    【ValueChanged<String>】",
//    }
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
