import 'package:flutter/material.dart';

//    {
//      "widgetId": 73,
//      "name": 'Opacity基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子组件   【Widget】\n"
//          "【opacity】 : 透明度0~1   【double】",
//    }
class CustomOpacity extends StatefulWidget {
  @override
  _CustomOpacityState createState() => _CustomOpacityState();
}

class _CustomOpacityState extends State<CustomOpacity> {
  var _opacity = 0.2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[_buildSlider(), _buildOpacity()],
    );
  }

  Widget _buildOpacity() => Opacity(
        opacity: _opacity,
        child: Image.asset(
          'assets/images/icon_head.png',
          width: 100,
        ),
      );
  Widget _buildSlider() => Slider(
      divisions: 20,
      label: _opacity.toString(),
      value: _opacity,
      onChanged: (v) => setState(() => _opacity = v));
}
