import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-31
/// contact me by email 1981462002@qq.com
/// 说明:
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
  const DivisionsSlider({Key? key}) : super(key: key);

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
        label: _value.toStringAsFixed(1),
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
