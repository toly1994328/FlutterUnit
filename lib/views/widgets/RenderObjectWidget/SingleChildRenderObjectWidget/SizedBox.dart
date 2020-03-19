import 'package:flutter/material.dart';

//    {
//      "widgetId": 76,
//      "name": 'SizedBox基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子组件   【Widget】\n"
//          "【width】 : 宽   【double】\n"
//          "【height】 : 高   【double】",
//    }
class CustomSizedBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var child = Container(
      alignment: Alignment.center,
      color: Colors.cyanAccent,
      width: 50,
      height: 50,
      child: Text("Static"),
    );

    var box = SizedBox(
      width: 80,
      height: 40,
      child: Container(
          color: Colors.orange,
          child: Icon(
            Icons.android,
            color: Colors.white,
          )),
    );

    return Container(
      color: Colors.grey.withAlpha(22),
      width: 200,
      height: 100,
      child: Row(
        children: <Widget>[child, box, child],
      ),
    );
  }
}
