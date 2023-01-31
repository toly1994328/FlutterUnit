import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-23
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 122,
//      "name": 'AnimatedPositionedDirectional基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子组件   【Widget】\n"
//          "【duration】 : 动画时长   【Duration】\n"
//          "【onEnd】 : 动画结束回调   【Function()】\n"
//          "【curve】 : 动画曲线   【Duration】\n"
//          "【top】 : 到父顶距离   【double】\n"
//          "【end】 : 到父右距离   【double】\n"
//          "【start】 : 到父左距离   【double】\n"
//          "【bottom】 : 到父底距离   【double】",
//    }
class CustomAnimatedPositionedDirectional extends StatefulWidget {
  const CustomAnimatedPositionedDirectional({Key? key}) : super(key: key);

  @override
  _CustomAnimatedPositionedDirectionalState createState() =>
      _CustomAnimatedPositionedDirectionalState();
}

class _CustomAnimatedPositionedDirectionalState
    extends State<CustomAnimatedPositionedDirectional> {
  final double startTop = 0.0;
  final double endTop = 30.0;

  double _top = 0.0;

  @override
  void initState() {
    _top = startTop;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildSwitch(),
        Container(
          color: Colors.grey.withAlpha(33),
          width: 200,
          height: 100,
          child: Stack(
            children: _buildChildren(),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildChildren() => <Widget>[
        AnimatedPositionedDirectional(
          duration: const Duration(seconds: 1),
          top: _top,
          start: _top * 4,
          child: const Icon(
            Icons.android,
            color: Colors.green,
            size: 50,
          ),
        ),
        AnimatedPositionedDirectional(
          duration: const Duration(seconds: 1),
          top: 50 - _top,
          start: 150 - _top * 4,
          child: const Icon(
            Icons.android,
            color: Colors.red,
            size: 50,
          ),
        )
      ];

  Widget _buildSwitch() => Switch(
      value: _top == endTop,
      onChanged: (v) {
        setState(() {
          _top = v ? endTop : startTop;
        });
      });
}
