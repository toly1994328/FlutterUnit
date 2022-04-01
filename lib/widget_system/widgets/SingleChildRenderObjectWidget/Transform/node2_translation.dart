import 'package:flutter/material.dart';

import 'matrix4_shower.dart';

/// create by 张风捷特烈 on 2020/4/30
/// contact me by email 1981462002@qq.com
/// 说明: 

//    {
//      "widgetId": 78,
//      "name": '平移变换translationValues',
//      "priority": 2,
//      "subtitle": "平移x由R0C3数控制,入参为数值,表示平移长度\n"
//          "平移y由R1C3数控制,入参为数值,表示平移长度\n"
//          "平移z由R2C3数控制,入参为数值,表示平移长度",
//    }
class TranslationTransform extends StatefulWidget {
  const TranslationTransform({Key? key}) : super(key: key);

  @override
  _TranslationTransformState createState() => _TranslationTransformState();
}

class _TranslationTransformState extends State<TranslationTransform> {
  late Matrix4 _m4;
  double _x = 0;
  double _y = 0;
  double _z = 0;

  @override
  void initState() {
    _m4 = Matrix4.identity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[_buildTransform(), Matrix4Shower(_m4)],
        ),
        _buildSliders()
      ],
    );
  }

  Widget _buildTransform() {
    _m4 = Matrix4.translationValues(_x, _y, _z);
    return Transform(
      transform: _m4,
      child: Container(
          color: Colors.cyanAccent,
          width: 100,
          height: 100,
          child: Image.asset(
            'assets/images/wy_300x200.webp',
            fit: BoxFit.cover,
          )),
    );
  }

  Widget _buildSliders() => Column(
    children: <Widget>[
      Slider(
          min: -100,
          max: 100,
          value: _x,
          divisions: 360,
          label: 'x:${_x.toStringAsFixed(1)}',
          onChanged: (v) {
            setState(() {
              _x = v;
            });
          }),
      Slider(
          min: -100,
          max: 100,
          value: _y,
          divisions: 360,
          label: 'y:${_y.toStringAsFixed(1)}',
          onChanged: (v) {
            setState(() {
              _y = v;
            });
          }),
      Slider(
          min: -100,
          max: 100,
          value: _z,
          divisions: 360,
          label: 'z:${_z.toStringAsFixed(1)}',
          onChanged: (v) {
            setState(() {
              _z = v;
            });
          })
    ],
  );
}
