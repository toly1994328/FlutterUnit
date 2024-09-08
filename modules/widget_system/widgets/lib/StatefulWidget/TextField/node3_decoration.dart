import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:
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
  const ComplexTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TextField(
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
