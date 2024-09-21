import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-31
/// contact me by email 1981462002@qq.com

class CustomCupertinoSwitch extends StatefulWidget {
  const CustomCupertinoSwitch({Key? key}) : super(key: key);

  @override
  _CustomCupertinoSwitchState createState() => _CustomCupertinoSwitchState();
}

class _CustomCupertinoSwitchState extends State<CustomCupertinoSwitch> {
  final List<Color> colors = [
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.green
  ];

  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: colors
          .map((e) => CupertinoSwitch(
              value: _checked,
              activeColor: e,
          onChanged: (v) {
            setState(() => _checked = v);
          })).toList(),
    );
  }
}
