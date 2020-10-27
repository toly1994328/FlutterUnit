import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020/4/30
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 77,
//      "name": 'AspectRatio基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子组件   【Widget】\n"
//          "【aspectRatio】 : 宽高比例   【double】",
//    }
class CustomAspectRatio extends StatefulWidget {
  @override
  _CustomAspectRatioState createState() => _CustomAspectRatioState();
}

class _CustomAspectRatioState extends State<CustomAspectRatio> {
  var _ratio = 0.75;

  @override
  Widget build(BuildContext context) {
    var child = Container(
      alignment: Alignment.center,
      color: Colors.cyanAccent,
      width: 50,
      height: 50,
      child: Text("Static"),
    );

    var box = AspectRatio(
      aspectRatio: _ratio,
      child: Container(
          color: Colors.orange,
          child: Icon(
            Icons.android,
            color: Colors.white,
          )),
    );

    return Column(
      children: <Widget>[
        _buildSlider(),
        Container(
          color: Colors.grey.withAlpha(22),
          width: 300,
          height: 100,
          child: Row(
            children: <Widget>[child, box, child],
          ),
        ),
      ],
    );
  }

  Widget _buildSlider() => Slider(
      divisions: 20,
      min: 0.1,
      max: 2.0,
      label: _ratio.toStringAsFixed(2),
      value: _ratio,
      onChanged: (v) => setState(() => _ratio = v));
}
