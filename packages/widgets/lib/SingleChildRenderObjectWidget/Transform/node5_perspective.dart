import 'dart:math';

import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/30
/// contact me by email 1981462002@qq.com
/// 说明: 

//    {
//      "widgetId": 78,
//      "name": '透视变换rotation',
//      "priority": 5,
//      "subtitle": "由R3C1、R3C2、R3C3控制透视",
//    }
class R3C2 extends StatefulWidget {
  const R3C2({Key? key}) : super(key: key);

  @override
  _R3C2State createState() => _R3C2State();
}

class _R3C2State extends State<R3C2> {
  late Matrix4 _m4;
  double _value = 0;
  double _rad = 0;

  @override
  Widget build(BuildContext context) {
    _m4 = Matrix4.identity()
//      ..setEntry(3, 0, _value) // x
//      ..setEntry(3, 1, _value)//   y
      ..setEntry(3, 2, _value) // z
      ..rotateY(_rad)
//      ..rotateX(_rad)
        ;
    return Column(
      children: <Widget>[
        Transform(
          transform: _m4,
          child: Container(
              color: Colors.cyanAccent,
              width: 100,
              height: 100,
              child: Image.asset(
                'assets/images/wy_300x200.webp',
                fit: BoxFit.cover,
              )),
        ),
        _buildSliders()
      ],
    );
  }

  Widget _buildSliders() => Column(
    children: <Widget>[
      Slider(
          min: -0.01,
          max: 0.01,
          value: _value,
          divisions: 360,
          label: 'x:${_value.toStringAsFixed(5)}',
          onChanged: (v) {
            setState(() {
              _value = v;
            });
          }),
      Slider(
          min: -pi,
          max: pi,
          value: _rad,
          divisions: 360,
          label: '角度:' + (_rad * 180 / pi).toStringAsFixed(1) + "°",
          onChanged: (v) {
            setState(() {
              _rad = v;
            });
          }),
    ],
  );
}