import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-23
/// contact me by email 1981462002@qq.com

class CustomAnimatedAlign extends StatefulWidget {
  const CustomAnimatedAlign({Key? key}) : super(key: key);

  @override
  _CustomAnimatedAlignState createState() => _CustomAnimatedAlignState();
}

class _CustomAnimatedAlignState extends State<CustomAnimatedAlign> {
  final Alignment start = const Alignment(0, 0);
  final Alignment end = Alignment.bottomRight;

  late Alignment _alignment;

  @override
  void initState() {
    _alignment = start;
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
          child: AnimatedAlign(
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            alignment: _alignment,
            onEnd: () => print('End'),
            child: Container(
              height: 40,
              width: 80,
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
          value: _alignment == end,
          onChanged: (v) {
            setState(() {
              _alignment = v ? end : start;
            });
          });
}
