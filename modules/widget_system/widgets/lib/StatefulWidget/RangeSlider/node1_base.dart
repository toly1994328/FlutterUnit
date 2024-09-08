import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 44,
//      "name": 'RangeSlider基本使用',
//      "priority": 1,
//      "subtitle": "【values】 : 数值   【RangeValues】\n"
//          "【min】 : 最小值   【double】\n"
//          "【max】 : 最大值   【double】\n"
//          "【divisions】 : 分段数   【int】\n"
//          "【label】 : 提示气泡文字   【String】\n"
//          "【activeColor】 : 激活颜色   【Color】\n"
//          "【inactiveColor】 : 非激活颜色   【Color】\n"
//          "【onChangeStart】 : 开始滑动时监听   【Function(RangeValues)】\n"
//          "【onChangeEnd】 : 滑动结束时监听   【Function(RangeValues)】\n"
//          "【onChanged】 : 改变时回调   【Function(RangeValues)】",
//    }
class CustomRangeSlider extends StatefulWidget {
  const CustomRangeSlider({Key? key}) : super(key: key);

  @override
  _CustomRangeSliderState createState() => _CustomRangeSliderState();
}

class _CustomRangeSliderState extends State<CustomRangeSlider> {
  RangeValues _rangeValues = const RangeValues(90, 270);

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
        values: _rangeValues,
        divisions: 180,
        min: 0.0,
        max: 360.0,
        labels: RangeLabels(_rangeValues.start.toStringAsFixed(1),
            _rangeValues.end.toStringAsFixed(1)),
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
            _rangeValues = value;
          });
        });
  }
}
