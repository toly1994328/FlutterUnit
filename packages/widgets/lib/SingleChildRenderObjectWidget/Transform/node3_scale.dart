import 'package:flutter/material.dart';
import 'matrix4_shower.dart';

/// create by 张风捷特烈 on 2020/4/30
/// contact me by email 1981462002@qq.com
/// 说明: 

//    {
//      "widgetId": 78,
//      "name": '缩放变换diagonal3Values',
//      "priority": 3,
//      "subtitle": "缩放x由R0C0数控制,入参为数值,表示缩放分率\n"
//          "缩放y由R1C2数控制,入参为数值,表示缩放分率\n"
//          "缩放z由R2C2数控制,入参为数值,表示缩放分率",
//    }
class ScaleTransform extends StatefulWidget {
  const ScaleTransform({Key? key}) : super(key: key);

  @override
  _ScaleTransformState createState() => _ScaleTransformState();
}

class _ScaleTransformState extends State<ScaleTransform> {
  late Matrix4 _m4;
  double _x = 1.0;
  double _y = 1.0;
  double _z = 1.0;

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
    _m4 = Matrix4.diagonal3Values(_x, _y, _z);
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
          min: -2,
          max: 2,
          value: _x,
          divisions: 360,
          label: 'x:${_x.toStringAsFixed(1)}',
          onChanged: (v) {
            setState(() {
              _x = v;
            });
          }),
      Slider(
          min: -2,
          max: 2,
          value: _y,
          divisions: 360,
          label: 'y:${_y.toStringAsFixed(1)}',
          onChanged: (v) {
            setState(() {
              _y = v;
            });
          }),
      Slider(
          min: -2,
          max: 2,
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