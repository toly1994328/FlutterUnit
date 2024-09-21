import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com


class ColorInkResponse extends StatefulWidget {
  const ColorInkResponse({Key? key}) : super(key: key);

  @override
  _ColorInkResponseState createState() => _ColorInkResponseState();
}

class _ColorInkResponseState extends State<ColorInkResponse> {
  String _info = 'Push';

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
