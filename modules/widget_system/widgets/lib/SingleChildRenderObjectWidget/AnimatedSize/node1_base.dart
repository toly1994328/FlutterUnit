import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-01
/// contact me by email 1981462002@qq.com


class CustomAnimatedSize extends StatefulWidget {
  const CustomAnimatedSize({Key? key}) : super(key: key);

  @override
  _CustomAnimatedSizeState createState() => _CustomAnimatedSizeState();
}

class _CustomAnimatedSizeState extends State<CustomAnimatedSize>
    with SingleTickerProviderStateMixin {
  final double start = 100;
  final double end = 200;

  late double _width;

  @override
  void initState() {
    _width = start;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildSwitch(),
        Container(
          color: Colors.grey.withAlpha(22),
          width: 200,
          height: 100,
          alignment: Alignment.center,
          child: AnimatedSize(
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            alignment: const Alignment(0, 0),
            child: Container(
              height: 40,
              width: _width,
              alignment: Alignment.center,
              color: Colors.blue,
              child: const Text(
                '张风捷特烈',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitch() => Switch(
      value: _width == end,
      onChanged: (v) {
        setState(() {
          _width = v ? end : start;
        });
      });
}
