import 'package:flutter/material.dart';
import 'package:flutter_unit/app/utils/color_utils.dart';

/// create by 张风捷特烈 on 2020-03-22
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 107,
//      "name": 'Spacer基本使用',
//      "priority": 1,
//      "subtitle":
//          "一个Spacer会占据可延伸区域",
//    }
class OneSpacer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
          Container(
            color: Colors.grey.withAlpha(33),
            child: Row(children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: 100,
                height: 50,
                color: Colors.red,
              ),
              Spacer(),
              Container(
                alignment: Alignment.center,
                width: 60,
                height: 50,
                color: Colors.blue,
              ),
            ],),
    );
  }
}

//    {
//      "widgetId": 107,
//      "name": '多个Spacer空间分配',
//      "priority": 2,
//      "subtitle":
//         "【flex】 : 剩余空间分配占比   【int】",
//    }
class ManySpacer extends StatefulWidget {
  @override
  _ManySpacerState createState() => _ManySpacerState();
}

class _ManySpacerState extends State<ManySpacer> {
  int _flexA=1;
  int _flexB=1;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          _buildSliders(),
          Container(
            color: Colors.grey.withAlpha(33),
            child: Row(children: <Widget>[
              Spacer(flex: _flexA),
              Container(
                alignment: Alignment.center,
                width: 100,
                height: 50,
                color: Colors.red,
              ),
              Spacer(flex: _flexB),
              Container(
                alignment: Alignment.center,
                width: 60,
                height: 50,
                color: Colors.blue,
              ),
            ],),
          )
        ],
    );
  }

  Widget _buildSliders() {
    return Column(
      children: <Widget>[
        Slider(
            divisions: 20,
            min: 1,
            max: 10,
            label: "左边flex: $_flexA",
            value: _flexA.toDouble(),
            onChanged: (v) => setState(() => _flexA = v.round())
        ),
        Slider(
            divisions: 20,
            label: "右边flex: $_flexB",
            min: 1,
            max: 10,
            value: _flexB.toDouble(),
            onChanged: (v) => setState(() => _flexB = v.round())
        ),
      ],
    );
  }
}