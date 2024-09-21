import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com


class CustomInkWell extends StatefulWidget {
  const CustomInkWell({Key? key}) : super(key: key);

  @override
  _CustomInkWellState createState() => _CustomInkWellState();
}

class _CustomInkWellState extends State<CustomInkWell> {
  String _info = 'Push';

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