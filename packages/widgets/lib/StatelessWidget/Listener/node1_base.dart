import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 147,
//      "name": 'Listener基本事件',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 子组件   【Widget】\n"
//          "【onPointerDown】 : 按下事件   【Function(PointerDownEvent)】\n"
//          "【onPointerMove】 : 移动事件   【Function(PointerMoveEvent)】\n"
//          "【onPointerMove】 : 抬起事件   【Function(PointerUpEvent)】\n"
//          "【onPointerCancel】 : 取消事件   【Function(PointerUpEvent)】",
//    }

class CustomListener extends StatefulWidget {
  const CustomListener({Key? key}) : super(key: key);

  @override
  _CustomListenerState createState() => _CustomListenerState();
}

class _CustomListenerState extends State<CustomListener> {
  String _info = '';

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (detail) => setState(() => _info = detail.toString()),
      onPointerMove: (detail) => setState(() => _info = detail.toString()),
      onPointerUp: (detail) => setState(() => _info = detail.toString()),
      onPointerCancel: (detail) => setState(() => _info = detail.toString()),

      child: Container(
        alignment: Alignment.center,
        width: 300,
        height: 300 * 0.618,
        color: Colors.grey.withAlpha(33),
        child: Text(
          _info,
          style: const TextStyle(fontSize: 16, color: Colors.blue),
        ),
      ),
    );
  }
}
