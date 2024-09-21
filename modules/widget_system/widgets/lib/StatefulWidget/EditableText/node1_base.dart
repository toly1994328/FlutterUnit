import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com


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
