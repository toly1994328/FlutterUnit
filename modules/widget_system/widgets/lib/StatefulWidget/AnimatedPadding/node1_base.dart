import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-23
/// contact me by email 1981462002@qq.com

class CustomAnimatedPadding extends StatefulWidget {
  const CustomAnimatedPadding({Key? key}) : super(key: key);

  @override
  _CustomAnimatedPaddingState createState() => _CustomAnimatedPaddingState();
}

class _CustomAnimatedPaddingState extends State<CustomAnimatedPadding> {
  final EdgeInsets startPadding = const EdgeInsets.all(10);
  final EdgeInsets endPadding = const EdgeInsets.all(30);

  late EdgeInsets _padding;

  @override
  void initState() {
    _padding = startPadding;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Switch(
            value: _padding == endPadding,
            onChanged: (v) {
              setState(() {
                _padding = v ? endPadding : startPadding;
              });
            }),
        Container(
          color: Colors.grey.withAlpha(22),
          width: 200,
          height: 100,
          child: AnimatedPadding(
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            padding: _padding,
            onEnd: () => print('End'),
            child: Container(
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
}
