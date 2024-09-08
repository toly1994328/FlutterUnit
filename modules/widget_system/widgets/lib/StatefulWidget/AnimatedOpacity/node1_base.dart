import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-23
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 118,
//      "name": 'AnimatedOpacity基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子组件   【Widget】\n"
//          "【duration】 : 动画时长   【Duration】\n"
//          "【onEnd】 : 动画结束回调   【Function()】\n"
//          "【curve】 : 动画曲线   【Duration】\n"
//          "【opacity】 : 透明度   【double】",
//    }
class CustomAnimatedOpacity extends StatefulWidget {
  const CustomAnimatedOpacity({Key? key}) : super(key: key);

  @override
  _CustomAnimatedOpacityState createState() => _CustomAnimatedOpacityState();
}

class _CustomAnimatedOpacityState extends State<CustomAnimatedOpacity> {
  double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Switch(
            value: _opacity == 0,
            onChanged: (v) {
              setState(() {
                _opacity = v ? 0 : 1.0;
              });
            }),
        Container(
          color: Colors.grey.withAlpha(22),
          width: 200,
          height: 100,
          child: AnimatedOpacity(
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            opacity: _opacity,
            onEnd: () => print('End'),
            child: const Icon(Icons.android, color: Colors.green, size: 60),
          ),
        ),
      ],
    );
  }
}
