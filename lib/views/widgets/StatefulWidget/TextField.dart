import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

//    {
//      "widgetId": 54,
//      "name": 'TextField基本语法',
//      "priority": 2,
//      "subtitle":
//          "【minLines】 : 最小行数   【int】\n"
//          "【maxLines】 : 最大行数   【int】\n"
//          "【cursorRadius】 : 光标半径   【Radius】\n"
//          "【cursorColor】 : 光标颜色   【Color】\n"
//          "【cursorWidth】 : 光标宽度   【double】\n"
//          "【showCursor】 : 是否显示光标   【bool】\n"
//          "【autofocus】 : 自动聚焦   【bool】",
//    }
class CursorTextField extends StatefulWidget {
  @override
  _CursorTextFieldState createState() => _CursorTextFieldState();
}

class _CursorTextFieldState extends State<CursorTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        _buildSubmitBtn(),
        _buildTextField(context),
      ],
    );
  }

  Container _buildTextField(BuildContext context) {
    return Container(
      width: 300,
      child: TextField(
        style: TextStyle(color: Colors.blue),
        minLines: 3,
        maxLines: 5,
        cursorColor: Colors.green,
        cursorRadius: Radius.circular(3),
        cursorWidth: 5,
        showCursor: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: "请输入...",
          border: OutlineInputBorder(),
        ),
        onChanged: (v) {},
      ),
    );
  }

  _buildSubmitBtn() => FlatButton(
      color: Colors.blue,
      child: Text(
        "提交",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      onPressed: () => FocusScope.of(context).requestFocus(_focusNode));
}

//    {
//      "widgetId": 54,
//      "name": 'decoration的复杂装饰',
//      "priority": 3,
//      "subtitle":
//          "InputDecoration有非常多的装饰点,对应点缀见代码:\n"
//          "border: 边线相关\n"
//          "helper: 左下角相关提示\n"
//          "counter: 右下角相关提示\n"
//          "prefix: 输入框内部最左侧\n"
//          "suffix: 输入框内部最右侧\n"
//          "label: 无焦点时文字\n"
//          "label: 无焦点时文字\n"
//          "hint: 提示文字相关\n"
//          "border: 边线相关",
//    }
class ComplexTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
        decoration: InputDecoration(
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurpleAccent),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
      labelText: 'username',
      labelStyle: TextStyle(color: Colors.purple),
      helperText: "help me",
      helperStyle: TextStyle(color: Colors.blue),

      suffixText: "suffix",
      suffixIcon: Icon(Icons.done),
      suffixStyle: TextStyle(color: Colors.green),

      counterText: "counter",
      counterStyle: TextStyle(color: Colors.orange),

      prefixText: "ID  ",
      prefixStyle: TextStyle(color: Colors.blue),
      prefixIcon: Icon(Icons.language),

      fillColor: Color(0x110099ee),
      filled: true,

      //  errorText: "error",
      //  errorMaxLines: 1,
      //  errorStyle: TextStyle(color: Colors.red),
      //  errorBorder: UnderlineInputBorder(),

      hintText: "请输入用户名",
      hintMaxLines: 1,
      hintStyle: TextStyle(color: Colors.black38),
      icon: Icon(Icons.assignment_ind),
    ));
  }
}
