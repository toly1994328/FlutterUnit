import 'package:flutter/material.dart';

//    {
//      "widgetId": 74,
//      "name": 'Padding基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子组件   【Widget】\n"
//          "【padding】 : 内四边距   【EdgeInsetsGeometry】",
//    }
class CustomPadding extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withAlpha(22),
      width: 200,
      height: 150,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: _buildChild(),
      ),
    );
  }

  Widget _buildChild() {
    return Container(
      alignment: Alignment.center,
      color: Colors.cyanAccent,
      width: 100,
      height: 100,
      child: Text("孩子"),
    );
  }
}
