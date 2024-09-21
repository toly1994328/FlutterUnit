import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-14
/// contact me by email 1981462002@qq.com

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({Key? key}) : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  final List<Color> colors = const[
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
          .map((e) => Switch(
              value: _checked,
              inactiveThumbColor: e,
              inactiveTrackColor: Colors.grey.withAlpha(88),
              activeColor: Colors.green,
              activeTrackColor: Colors.orange,
              onChanged: (v) {
                setState(() => _checked = v);
              }))
          .toList(),
    );
  }
}

