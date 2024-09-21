import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-23
/// contact me by email 1981462002@qq.com

class CustomAnimatedPositioned extends StatefulWidget {
  const CustomAnimatedPositioned({Key? key}) : super(key: key);

  @override
  _CustomAnimatedPositionedState createState() =>
      _CustomAnimatedPositionedState();
}

class _CustomAnimatedPositionedState extends State<CustomAnimatedPositioned> {
  final double startTop = 0.0;
  final double endTop = 30.0;

  double _top = 0.0;

  @override
  void initState() {
    _top = startTop;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildSwitch(),
        Container(
          color: Colors.grey.withAlpha(33),
          width: 200,
          height: 100,
          child: Stack(
            children: _buildChildren(),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildChildren() => <Widget>[
        AnimatedPositioned(
          duration: const Duration(seconds: 1),
          top: _top,
          left: _top * 4,
          child: const Icon(
            Icons.android,
            color: Colors.green,
            size: 50,
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(seconds: 1),
          top: 50 - _top,
          left: 150 - _top * 4,
          child: const Icon(
            Icons.android,
            color: Colors.red,
            size: 50,
          ),
        )
      ];

  Widget _buildSwitch() => Switch(
      value: _top == endTop,
      onChanged: (v) {
        setState(() {
          _top = v ? endTop : startTop;
        });
      });
}
