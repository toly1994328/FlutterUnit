import 'dart:math';

import 'package:flutter/material.dart';

import 'matrix4_shower.dart';

/// create by 张风捷特烈 on 2020/4/30
/// contact me by email 1981462002@qq.com
/// 说明: 

//    {
//      "widgetId": 78,
//      "name": '旋转变换rotation',
//      "priority": 4,
//      "subtitle": "x旋转由R1C1、R1C2、R2C1、R2C2控制,入参表示弧度\n"
//          "y旋转由R0C0、R0C2、R2C0、R2C2控制,入参表示弧度\n"
//          "z旋转由R0C0、R0C1、R1C0、R1C1控制,入参表示弧度\n"
//    }
class RotateTransform extends StatefulWidget {
  const RotateTransform({Key? key}) : super(key: key);

  @override
  _RotateTransformState createState() => _RotateTransformState();
}

class _RotateTransformState extends State<RotateTransform> {
  late Matrix4 _m4;
  double _x = 0;
  int _rotateFlag = 1;

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
    if (_rotateFlag == 1) {
      _m4 = Matrix4.rotationX(_x);
    } else if (_rotateFlag == 2) {
      _m4 = Matrix4.rotationY(_x);
    } else {
      _m4 = Matrix4.rotationZ(_x);
    }

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

  final Map<int, String> map = {
    1: 'rotationX',
    2: 'rotationY',
    3: 'rotationZ',
  };

  Widget _buildSliders() => Column(
    children: <Widget>[
      Wrap(
        children: map.keys.map((key) => _buildChild(key)).toList(),
      ),
      Slider(
          min: -pi,
          max: pi,
          value: _x,
          divisions: 360,
          label: 'x:${_x.toStringAsFixed(1)}',
          onChanged: (v) {
            setState(() {
              _x = v;
            });
          }),
    ],
  );

  Padding _buildChild(int key) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: FilterChip(
        selectedColor: Colors.orange.withAlpha(55),
        selectedShadowColor: Colors.blue,
        shadowColor: Colors.orangeAccent,
        pressElevation: 5,
        elevation: 3,
        avatar: CircleAvatar(child: Text(key.toString())),
        label: Text(map[key]!),
        selected: _rotateFlag == key,
        onSelected: (bool value) {
          print(map[key]);
          setState(() {
            _x = 0;
            if (value) {
              _rotateFlag = key;
            }
          });
        },
      ),
    );
  }
}
