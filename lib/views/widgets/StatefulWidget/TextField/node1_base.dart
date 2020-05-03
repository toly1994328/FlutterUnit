import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
/// create by 张风捷特烈 on 2020/4/30
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 54,
//      "name": 'TextField基本用法',
//      "priority": 1,
//      "subtitle":
//          "【controller】 : 控制器   【TextEditingController】\n"
//          "【style】 : 文字样式   【TextStyle】\n"
//          "【decoration】 : 装饰线   【InputDecoration】\n"
//          "【onEditingComplete】 : 输入完成事件   【Function()】\n"
//          "【onSubmitted】 : 提交事件   【Function(String)】\n"
//          "【onChanged】 : 输入事件   【Function(String)】",
//    }
class CustomTextField extends StatefulWidget {
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  TextEditingController _controller;

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        child: TextField(
          controller: _controller,
          style: TextStyle(color: Colors.blue),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'username',
          ),
          onEditingComplete: () {
            print('onEditingComplete');
          },
          onChanged: (v) {
            print('onChanged:' + v);
          },
          onSubmitted: (v) {
            FocusScope.of(context).requestFocus(_focusNode);
            print('onSubmitted:' + v);
            _controller.clear();
          },
        ));
  }
}

