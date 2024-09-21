import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-31
/// contact me by email 1981462002@qq.com

class CustomCupertinoSlider extends StatefulWidget {
  const CustomCupertinoSlider({Key? key}) : super(key: key);

  @override
  _CustomCupertinoSliderState createState() => _CustomCupertinoSliderState();
}

class _CustomCupertinoSliderState extends State<CustomCupertinoSlider> {
  double _value = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('当前值:${_value.toStringAsFixed(1)}'),
        CupertinoSlider(
            value: _value,
            divisions: 180,
            min: 0.0,
            max: 360.0,
            activeColor: Colors.green,
            thumbColor: Colors.white,
            onChangeStart: (value) => print('开始滑动:$value'),
            onChangeEnd: (value) => print('滑动结束:$value'),
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            }),
      ],
    );
  }
}
