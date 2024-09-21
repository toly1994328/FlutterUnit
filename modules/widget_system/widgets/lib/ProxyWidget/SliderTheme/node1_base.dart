import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-12
/// contact me by email 1981462002@qq.com


class SliderThemeDemo extends StatefulWidget {
  const SliderThemeDemo({Key? key}) : super(key: key);

  @override
  _SliderThemeDemoState createState() => _SliderThemeDemoState();
}

class _SliderThemeDemoState extends State<SliderThemeDemo> {
  double _bliss = 0.5;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(activeTrackColor: Colors.orange),
      child: Slider(
        min: 0.0,
        max: 200.0,
        divisions: 10,
        label: _bliss.toStringAsFixed(1),
        onChanged: (double value) {
          setState(() {
            _bliss = value;
          });
        },
        value: _bliss,
      ),
    );
  }
}