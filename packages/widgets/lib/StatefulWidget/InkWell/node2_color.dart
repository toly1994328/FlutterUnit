import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 150,
//      "name": 'InkWell其他属性',
//      "priority": 2,
//      "subtitle": "【child】 : 子组件   【Widget】\n"
//          "【onHighlightChanged】 : 高亮变化回调   【Function(bool)】\n"
//          "【highlightColor】 : 高亮色   【Color】\n"
//          "【splashColor】 : 水波纹色   【Color】\n"
//          "【radius】 : 水波半径   【double】",
//    }

class ColorInkWell extends StatefulWidget {
  const ColorInkWell({Key? key}) : super(key: key);

  @override
  _ColorInkWellState createState() => _ColorInkWellState();
}

class _ColorInkWellState extends State<ColorInkWell> {
  String _info = 'Push';

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
