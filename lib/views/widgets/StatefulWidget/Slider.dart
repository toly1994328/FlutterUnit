import 'package:flutter/material.dart';

//    {
//      "widgetId": 42,
//      "name": 'Slider基本使用',
//      "priority": 1,
//      "subtitle":
//          "【value】 : 数值   【double】\n"
//          "【min】 : 最小值   【double】\n"
//          "【max】 : 最大值   【double】\n"
//          "【activeColor】 : 激活颜色   【Color】\n"
//          "【inactiveColor】 : 非激活颜色   【Color】\n"
//          "【onChanged】 : 改变时回调   【Function(double)】",
//    }
class CustomSlider extends StatefulWidget {
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
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            }),
      ],
    );
  }
}

//    {
//      "widgetId": 42,
//      "name": 'Slider的分段与标签',
//      "priority": 2,
//      "subtitle":
//          "【divisions】 : 分段数   【int】\n"
//          "【label】 : 提示气泡文字   【String】\n"
//          "【onChangeStart】 : 开始滑动时监听   【Function(double)】\n"
//          "【onChangeEnd】 : 滑动结束时监听   【Function(double)】",
//    }
class DivisionsSlider extends StatefulWidget {
  @override
  _DivisionsSliderState createState() => _DivisionsSliderState();
}

class _DivisionsSliderState extends State<DivisionsSlider> {
  double _value = 0.0;

  @override
  Widget build(BuildContext context) {
    return Slider(
        value: _value,
        min: 0.0,
        max: 360.0,
        divisions: 10,
        label: '${_value.toStringAsFixed(1)}',
        activeColor: Colors.orangeAccent,
        inactiveColor: Colors.green.withAlpha(99),
        onChangeStart: (value) {
          print('开始滑动:$value');
        },
        onChangeEnd: (value) {
          print('滑动结束:$value');
        },
        onChanged: (value) {
          setState(() {
            _value = value;
          });
        });
  }
}
