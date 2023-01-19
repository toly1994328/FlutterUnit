import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com
/// 说明: 231 InputDecorator 输入装饰 在外层包裹输入的装饰,是TextField的底层核心组件之一，一般不单独使用。
//    {
//      "widgetId": 231,
//      "name": "InputDecorator基本使用",
//      "priority": 1,
//      "subtitle": "【decoration】 : 装饰对象   【InputDecoration】\n"
//          "【textAlign】 : 文字对齐方式   【TextAlign】\n"
//          "【child】 : 子组件   【Widget】",
//    }

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
