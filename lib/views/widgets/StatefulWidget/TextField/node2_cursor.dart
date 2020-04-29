import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 54,
//      "name": 'TextField行数和cursor',
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
