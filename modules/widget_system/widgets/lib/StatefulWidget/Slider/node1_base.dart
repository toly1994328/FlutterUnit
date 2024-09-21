import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-31
/// contact me by email 1981462002@qq.com

class CustomSlider extends StatefulWidget {
  const CustomSlider({Key? key}) : super(key: key);

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _value = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('当前值:${_value.toStringAsFixed(1)}'),
        Slider(
            value: _value,
            min: 0.0,
            max: 360.0,
            activeColor: Colors.orangeAccent,
            inactiveColor: Colors.green.withAlpha(99),
            onChanged: _onChange),
      ],
    );
  }

  void _onChange(value) {
    setState(() {
      _value = value;
    });
  }
}
