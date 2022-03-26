import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com
/// 说明: 244 EditableText 可编辑文字 可以编辑的文字,是TextField的底层最核心组件，一般不单独使用。
//    {
//      "widgetId": 244,
//      "name": "EditableText基本使用",
//      "priority": 1,
//      "subtitle": "【controller】 : 控制器   【TextEditingController】\n"
//          "【focusNode】 : 焦点   【FocusNode】\n"
//          "【style】 : 文字样式   【TextStyle】\n"
//          "【backgroundCursorColor】 : 背景游标颜色   【Color】\n"
//          "【cursorColor】 : 游标颜色   【Color】\n"
//          "上面五个是EditableText必须的属性，其他同TextField,此处不再列举。",
//    }

class EditableTextDemo extends StatefulWidget {
  const EditableTextDemo({Key? key}) : super(key: key);

  @override
  _EditableTextDemoState createState() => _EditableTextDemoState();
}

class _EditableTextDemoState extends State<EditableTextDemo> {
  final TextEditingController _ctrl =
      TextEditingController(text: 'Hello Flutter Unit!');
  final FocusNode _node = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: EditableText(
        controller: _ctrl,
        focusNode: _node,
        style: const TextStyle(fontSize: 16, color: Colors.blue),
        cursorColor: Colors.blue,
        backgroundCursorColor: Colors.orange,
      ),
    );
  }
}
