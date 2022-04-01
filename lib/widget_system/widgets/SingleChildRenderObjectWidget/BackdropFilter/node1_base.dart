import 'dart:ui';

import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-19
/// contact me by email 1981462002@qq.com
/// 说明:


//    {
//      "widgetId": 278,
//      "name": 'BackdropFilter基本使用',
//      "priority": 1,
//      "subtitle": "【child】 : 孩子组件   【Widget】\n"
//          "【filter】 : 过滤器   【ImageFilter】\n"
//          "ImageFilter.blur可以实现高斯模糊，指定x，y模糊因子。",
//    }

class CustomBackdropFilter extends StatefulWidget {
  const CustomBackdropFilter({Key? key}) : super(key: key);

  @override
  _CustomBackdropFilterState createState() => _CustomBackdropFilterState();
}

class _CustomBackdropFilterState extends State<CustomBackdropFilter> {
  double _sigmaX = 1.2;
  double _sigmaY = 1.2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            _buildImage(),
            Positioned.fill(
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                  child: Container(
                    color: Colors.black.withAlpha(0),
                  ),
                ),
              ),
            )
          ],
        ),
        _buildSliders()
      ],
    );
  }

  Widget _buildImage() {
    return Wrap(
      spacing: 20,
      children: <Widget>[
        SizedBox(
          height: 150,
          width: 150,
          child: Image.asset(
            'assets/images/sabar.webp',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 150,
          width: 150,
          child: Image.asset(
            'assets/images/wy_200x300.webp',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _buildSliders() => Column(
        children: <Widget>[
          Slider(
              min: 0,
              max: 4,
              value: _sigmaX,
              divisions: 360,
              label: 'x:' + _sigmaX.toStringAsFixed(1),
              onChanged: (v) {
                setState(() {
                  _sigmaX = v;
                });
              }),
          Slider(
              min: 0,
              max: 4,
              value: _sigmaY,
              divisions: 360,
              label: 'beta:' + _sigmaY.toStringAsFixed(1),
              onChanged: (v) {
                setState(() {
                  _sigmaY = v;
                });
              })
        ],
      );
}
