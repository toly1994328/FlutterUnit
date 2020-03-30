import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 150,
//      "name": 'InkWell基本事件',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 子组件   【Widget】\n"
//          "【onTap】 : 点击事件   【Function()】\n"
//          "【onDoubleTap】 : 双击事件   【Function()】\n"
//          "【onTapCancel】 : 点击取消   【Function()】\n"
//          "【onLongPress】 : 长按事件   【Function()】",
//    }

class CustomInkWell extends StatefulWidget {
  @override
  _CustomInkWellState createState() => _CustomInkWellState();
}

class _CustomInkWellState extends State<CustomInkWell> {
  var _info = 'Push';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() => _info = 'onTap'),
      onDoubleTap: () => setState(() => _info = 'onDoubleTap'),
      onLongPress: () => setState(() => _info = 'onLongPress'),
      onTapCancel: () => setState(() => _info = 'onTapCancel'),
      child: Container(
        alignment: Alignment.center,
        width: 120,
        height: 50,
        child: Text(_info),
      ),
    );
  }
}

//    {
//      "widgetId": 150,
//      "name": 'InkWell其他属性',
//      "priority": 2,
//      "subtitle":
//          "【child】 : 子组件   【Widget】\n"
//          "【onHighlightChanged】 : 高亮变化回调   【Function(bool)】\n"
//          "【highlightColor】 : 高亮色   【Color】\n"
//          "【splashColor】 : 水波纹色   【Color】\n"
//          "【radius】 : 水波半径   【double】",
//    }

class ColorInkWell extends StatefulWidget {
  @override
  _ColorInkWellState createState() => _ColorInkWellState();
}

class _ColorInkWellState extends State<ColorInkWell> {
  var _info = 'Push';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {},
      splashColor: Colors.blueAccent,
      highlightColor: Colors.orange,
      onHighlightChanged: (v) =>
          setState(() => _info = 'onHighlightChanged:$v'),
      radius: 50,
      child: Container(
        alignment: Alignment.center,
        width: 180,
        height: 50,
        child: Text(_info),
      ),
    );
  }
}
