import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-04-19
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 82,
//      "name": 'FractionallySizedBox基本使用',
//      "priority": 1,
//      "subtitle": "【child】 : 孩子组件   【Widget】\n"
//          "【widthFactor】 : 宽分率   【double】\n"
//          "【heightFactor】 : 高分率   【double】\n"
//          "【alignment】 : 对齐方式   【AlignmentGeometry】",
//    }
class CustomFractionallySizedBox extends StatefulWidget {
  const CustomFractionallySizedBox({Key? key}) : super(key: key);

  @override
  _CustomFractionallySizedBoxState createState() =>
      _CustomFractionallySizedBoxState();
}

class _CustomFractionallySizedBoxState
    extends State<CustomFractionallySizedBox> {
  double _hf = 0.5;
  double _wf = 0.4;

  @override
  Widget build(BuildContext context) {
    Widget box = FractionallySizedBox(
      widthFactor: _wf,
      heightFactor: _hf,
      alignment: Alignment.center,
      child: Container(color: Colors.orange),
    );
    return Column(
      children: <Widget>[
        Container(
            color: Colors.grey.withAlpha(22),
            width: 200,
            height: 100,
            child: box),
        _buildSlider()
      ],
    );
  }

  Widget _buildSlider() => Column(
    children: <Widget>[
      Slider(
          divisions: 20,
          min: 0.0,
          max: 2,
          label: '宽分率:' + _wf.toStringAsFixed(1),
          value: _wf,
          onChanged: (v) => setState(() => _wf = v)),
      Slider(
          divisions: 20,
          min: 0.0,
          max: 2,
          label: '高分率:' + _hf.toStringAsFixed(1),
          value: _hf,
          onChanged: (v) => setState(() => _hf = v)),
    ],
  );
}
