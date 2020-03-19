import 'dart:math';
import 'dart:math' as prefix0;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTransform extends StatefulWidget {
  @override
  _CustomTransformState createState() => _CustomTransformState();
}

class _CustomTransformState extends State<CustomTransform> {
  var angle = 0.0;
  var m = [
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    0.1,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
  ];

  @override
  Widget build(BuildContext context) {
    var transform = Transform(
      transform: Matrix4(m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7], m[8],
          m[9], m[10], m[11], m[12], m[13], m[14], m[15]),
      child: Container(
          alignment: Alignment.center,
          color: Colors.cyanAccent,
          width: 100,
          height: 100,
          child: Image.asset(
            'assets/images/wy_300x200.jpg',
            fit: BoxFit.cover,
          )),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              color: Colors.grey.withAlpha(22),
              width: 200,
              height: 150,
              child: transform,
            ),
            Text(
              '${m[0]},${m[1]},${m[2]},${m[3]},\n'
              '${m[4]},${m[5]},${m[6]},${m[7]},\n'
              '${m[8]},${m[9]},${m[10]},${m[11]},\n'
              '${m[12]},${m[13]},${m[14]},${m[15]}\n',
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: _buildSliders())
      ],
    );
  }

  Widget _buildSliders() => GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 8,
      children: m
          .asMap()
          .keys
          .map((i) => Slider(
              value: m[i],
              max: 0.01,
              min: 0.0,
              divisions: 10,
              onChanged: (v) {
                setState(() {
                  m[i] = v;
                });
              }))
          .toList());
}

//    {
//      "widgetId": 78,
//      "name": '斜切变换skew',
//      "priority": 1,
//      "subtitle":
//          "斜切x由R0C1数控制,入参为弧度值,表示斜切角度\n"
//          "斜切y由R1C0数控制,入参为弧度值,表示斜切角度",
//    }
class SkewTransform extends StatefulWidget {
  @override
  _SkewTransformState createState() => _SkewTransformState();
}

class _SkewTransformState extends State<SkewTransform> {
  Matrix4 _m4;
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
            'assets/images/wy_300x200.jpg',
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
//    {
//      "widgetId": 78,
//      "name": '平移变换translationValues',
//      "priority": 2,
//      "subtitle":
//          "平移x由R0C3数控制,入参为数值,表示平移长度\n"
//          "平移y由R1C3数控制,入参为数值,表示平移长度\n"
//          "平移z由R2C3数控制,入参为数值,表示平移长度",
//    }
class TranslationTransform extends StatefulWidget {
  @override
  _TranslationTransformState createState() => _TranslationTransformState();
}

class _TranslationTransformState extends State<TranslationTransform> {
  Matrix4 _m4;
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
            'assets/images/wy_300x200.jpg',
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
//    {
//      "widgetId": 78,
//      "name": '缩放变换diagonal3Values',
//      "priority": 3,
//      "subtitle":
//          "缩放x由R0C0数控制,入参为数值,表示缩放分率\n"
//          "缩放y由R1C2数控制,入参为数值,表示缩放分率\n"
//          "缩放z由R2C2数控制,入参为数值,表示缩放分率",
//    }
class ScaleTransform extends StatefulWidget {
  @override
  _ScaleTransformState createState() => _ScaleTransformState();
}

class _ScaleTransformState extends State<ScaleTransform> {
  Matrix4 _m4;
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
            'assets/images/wy_300x200.jpg',
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
//    {
//      "widgetId": 78,
//      "name": '旋转变换rotation',
//      "priority": 4,
//      "subtitle":
//          "x旋转由R1C1、R1C2、R2C1、R2C2控制,入参表示弧度\n"
//          "y旋转由R0C0、R0C2、R2C0、R2C2控制,入参表示弧度\n"
//          "z旋转由R0C0、R0C1、R1C0、R1C1控制,入参表示弧度\n"
//    }
class RotateTransform extends StatefulWidget {
  @override
  _RotateTransformState createState() => _RotateTransformState();
}

class _RotateTransformState extends State<RotateTransform> {
  Matrix4 _m4;
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
            'assets/images/wy_300x200.jpg',
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
        label: Text(map[key]),
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
//    {
//      "widgetId": 78,
//      "name": '透视变换rotation',
//      "priority": 5,
//      "subtitle":
//          "由R3C1、R3C2、R3C3控制透视"
//    }
class R3C2 extends StatefulWidget {
  @override
  _R3C2State createState() => _R3C2State();
}

class _R3C2State extends State<R3C2> {
  Matrix4 _m4;
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
                'assets/images/wy_300x200.jpg',
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

class Matrix4Shower extends StatelessWidget {
  final Matrix4 matrix4;

  Matrix4Shower(this.matrix4);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '${matrix4.entry(0, 0).toStringAsFixed(1)},${matrix4.entry(0, 1).toStringAsFixed(1)},${matrix4.entry(0, 2).toStringAsFixed(1)},${matrix4.entry(0, 3).toStringAsFixed(1)},\n'
        '${matrix4.entry(1, 0).toStringAsFixed(1)},${matrix4.entry(1, 1).toStringAsFixed(1)},${matrix4.entry(1, 2).toStringAsFixed(1)},${matrix4.entry(1, 3).toStringAsFixed(1)},\n'
        '${matrix4.entry(2, 0).toStringAsFixed(1)},${matrix4.entry(2, 1).toStringAsFixed(1)},${matrix4.entry(2, 2).toStringAsFixed(1)},${matrix4.entry(2, 3).toStringAsFixed(1)},\n'
        '${matrix4.entry(3, 0).toStringAsFixed(1)},${matrix4.entry(3, 1).toStringAsFixed(1)},${matrix4.entry(3, 2).toStringAsFixed(1)},${matrix4.entry(3, 3).toStringAsFixed(1)}',
        style: TextStyle(fontSize: 20, color: Colors.blue),
      ),
    );
  }
}
