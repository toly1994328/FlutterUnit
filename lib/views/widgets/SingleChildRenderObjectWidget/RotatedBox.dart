import 'package:flutter/material.dart';

//    {
//      "widgetId": 72,
//      "name": 'RotatedBox基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子组件   【Widget】\n"
//          "【quarterTurns】 : 旋转多少个90°   【int】",
//    }
class CustomRotatedBox extends StatefulWidget {
  @override
  _CustomRotatedBoxState createState() => _CustomRotatedBoxState();
}

class _CustomRotatedBoxState extends State<CustomRotatedBox> {
  int _quarterTurns = 0;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: _quarterTurns,
      child: GestureDetector(
          onTap: () => setState(() => _quarterTurns++),
          child: Icon(
            Icons.android,
            size: 60,
            color: Colors.blue,
          )),
    );
  }
}
