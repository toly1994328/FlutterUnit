import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com


class InputDecoratorDemo extends StatelessWidget {
  const InputDecoratorDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InputDecorator(
        decoration: const InputDecoration(),
        child: EditableText(
            controller: TextEditingController(text:'hello'),
            focusNode: FocusNode(),
            style: const TextStyle(fontSize: 12,color: Colors.black),
            cursorColor: Colors.blue,
            backgroundCursorColor: Colors.orange,
        ),
      ),
    );
  }
}
