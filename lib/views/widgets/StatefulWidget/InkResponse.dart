import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 149,
//      "name": 'InkResponse基本事件',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 子组件   【Widget】\n"
//          "【onTap】 : 点击事件   【Function()】\n"
//          "【onDoubleTap】 : 双击事件   【Function()】\n"
//          "【onTapCancel】 : 点击取消   【Function()】\n"
//          "【onLongPress】 : 长按事件   【Function()】",
//    }

class CustomInkResponse extends StatefulWidget {
  @override
  _CustomInkResponseState createState() => _CustomInkResponseState();
}

class _CustomInkResponseState extends State<CustomInkResponse> {
  var _info = 'Push';

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => setState(() => _info = 'onTap'),
      onDoubleTap: () => setState(() => _info = 'onDoubleTap'),
      onLongPress: () => setState(() => _info = 'onLongPress'),
      onTapCancel: () => setState(() => _info = 'onTapCancel'),
      child: Container(
        alignment: Alignment.center,
        width: 200,
        height: 100,
        child: Text(_info),
      ),
    );
  }
}

//    {
//      "widgetId": 149,
//      "name": 'InkResponse其他属性',
//      "priority": 2,
//      "subtitle":
//          "【child】 : 子组件   【Widget】\n"
//          "【onHighlightChanged】 : 高亮变化回调   【Function(bool)】\n"
//          "【highlightColor】 : 高亮色   【Color】\n"
//          "【splashColor】 : 水波纹色   【Color】\n"
//          "【radius】 : 水波半径   【double】",
//    }

class ColorInkResponse extends StatefulWidget {
  @override
  _ColorInkResponseState createState() => _ColorInkResponseState();
}

class _ColorInkResponseState extends State<ColorInkResponse> {
  var _info = 'Push';

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => {},
      splashColor: Colors.blueAccent,
      highlightColor: Colors.orange,
      onHighlightChanged: (v) =>
          setState(() => _info = 'onHighlightChanged:$v'),
      radius: 50,
      child: Container(
        alignment: Alignment.center,
        width: 200,
        height: 100,
        child: Text(_info),
      ),
    );
  }
}
