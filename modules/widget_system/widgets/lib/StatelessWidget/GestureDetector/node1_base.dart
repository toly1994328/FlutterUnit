import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/27
/// contact me by email 1981462002@qq.com


class CustomGestureDetector extends StatefulWidget {
  const CustomGestureDetector({Key? key}) : super(key: key);

  @override
  _CustomGestureDetectorState createState() => _CustomGestureDetectorState();
}

class _CustomGestureDetectorState extends State<CustomGestureDetector> {
  String _info = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _info = 'onTap'),
      onDoubleTap: () => setState(() => _info = 'onDoubleTap'),
      onLongPress: () => setState(() => _info = 'onLongPress'),
      child: Container(
        alignment: Alignment.center,
        width: 300,
        height: 300 * 0.4,
        color: Colors.grey.withAlpha(33),
        child: Text(
          _info,
          style: const TextStyle(fontSize: 18, color: Colors.blue),
        ),
      ),
    );
  }
}