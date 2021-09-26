import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-22
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 109,
//      "name": 'Flexible基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子   【Widget】\n"
//          "【fit】 : 适应模式*2   【FlexFit】\n"
//          "【flex】 : 剩余空间分配占比   【int】",
//    }
class CustomFlexible extends StatefulWidget {
  @override
  _CustomFlexibleState createState() => _CustomFlexibleState();
}

class _CustomFlexibleState extends State<CustomFlexible> {
  double _width = 300.0;
  bool _loose = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          color: Colors.grey.withAlpha(33),
          width: _width,
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Flexible(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  color: Colors.red,
                  child: Text(
                    'flex=2',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  color: Colors.blue,
                  child: Text(
                    'flex=3',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Flexible(
                flex: 4,
                fit: _loose?FlexFit.loose:FlexFit.tight,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 60),
                  alignment: Alignment.center,
                  height: 50,
                  color: Colors.green,
                  child: Text(
                    'flex=4 \nfit:${_loose?'loose':'tight'}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          )),
      _buildOp()
    ]);
  }

  Widget _buildOp() {
    return Row(
      children: <Widget>[
        Switch(
            value: _loose,
            onChanged: (v) => setState(() => _loose = v)),
        Expanded(
          child: Slider(
            divisions: 10,
              min: 100,
              max: 350,
              value: _width,
              onChanged: (v) => setState(() => _width = v)),
        ),
      ],
    );
  }
}
