import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com


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
