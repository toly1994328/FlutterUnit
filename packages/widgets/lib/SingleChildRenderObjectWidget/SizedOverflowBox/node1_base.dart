import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-04-19
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 84,
//      "name": 'SizedOverflowBox基本使用',
//      "priority": 1,
//      "subtitle": "【child】 : 孩子组件   【Widget】\n"
//          "【size】 : 尺寸偏移   【Size】\n"
//          "【alignment】 : 对齐方式   【AlignmentGeometry】",
//    }
class CustomSizedOverflowBox extends StatefulWidget {
  const CustomSizedOverflowBox({Key? key}) : super(key: key);

  @override
  _CustomSizedOverflowBoxState createState() => _CustomSizedOverflowBoxState();
}

class _CustomSizedOverflowBoxState extends State<CustomSizedOverflowBox> {
  double _x = 50;
  double _y = 44;

  @override
  Widget build(BuildContext context) {
    Widget box = SizedOverflowBox(
      alignment: Alignment.bottomRight,
      size: Size(_x, _y),
      child: Container(width: 30, height: 50, color: Colors.orange),
    );
    return Column(
      children: <Widget>[
        Container(
            alignment: Alignment.topLeft,
            color: Colors.grey.withAlpha(88),
            width: 250,
            height: 60,
            child: box),
        _buildSlider()
      ],
    );
  }

  Widget _buildSlider() =>
      Column(
        children: <Widget>[
          Slider(
              divisions: 100,
              min: 0,
              max: 250,
              label: 'x:' + _x.toStringAsFixed(1),
              value: _x,
              onChanged: (v) => setState(() => _x = v)),
          Slider(
              divisions: 100,
              min: 0,
              max: 100,
              label: 'y:' + _y.toStringAsFixed(1),
              value: _y,
              onChanged: (v) => setState(() => _y = v)),

        ],
      );
}
