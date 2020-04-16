import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//    {
//      "widgetId": 48,
//      "name": 'CupertinoActivityIndicator基本使用',
//      "priority": 1,
//      "subtitle":
//          "【animating】 : 是否loading动画   【bool】\n"
//          "【radius】 : 半径   【double】"
//    }
class CustomCupertinoActivityIndicator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Wrap(
      spacing: 20,
      children: <Widget>[
        CupertinoActivityIndicator(
          animating: true,
          radius: 25,
        ),
        CupertinoActivityIndicator(
          animating: false,
          radius: 25,
        )
      ],
    );
  }
}
