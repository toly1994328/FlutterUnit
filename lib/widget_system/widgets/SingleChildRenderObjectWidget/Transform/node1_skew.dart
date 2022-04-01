import 'dart:math';
import 'package:flutter/material.dart';

import 'matrix4_shower.dart';

/// create by 张风捷特烈 on 2020-04-19
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 78,
//      "name": '斜切变换skew',
//      "priority": 1,
//      "subtitle": "斜切x由R0C1数控制,入参为弧度值,表示斜切角度\n"
//          "斜切y由R1C0数控制,入参为弧度值,表示斜切角度",
//    }
class SkewTransform extends StatefulWidget {
  const SkewTransform({Key? key}) : super(key: key);

  @override
  _SkewTransformState createState() => _SkewTransformState();
}

class _SkewTransformState extends State<SkewTransform> {
  late Matrix4 _m4;
  double _alpha = 0;
  double _beta = 0;

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
    _m4 = Matrix4.skew(_alpha, _beta);
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
              min: -pi,
              max: pi,
              value: _alpha,
              divisions: 360,
              label: 'alpha:' + (_alpha * 180 / pi).toStringAsFixed(1) + "°",
              onChanged: (v) {
                setState(() {
                  _alpha = v;
                });
              }),
          Slider(
              min: -pi,
              max: pi,
              value: _beta,
              divisions: 360,
              label: 'beta:' + (_beta * 180 / pi).toStringAsFixed(1) + "°",
              onChanged: (v) {
                setState(() {
                  _beta = v;
                });
              })
        ],
      );
}