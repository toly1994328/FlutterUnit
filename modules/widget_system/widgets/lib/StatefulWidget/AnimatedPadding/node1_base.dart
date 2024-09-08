import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-23
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 119,
//      "name": 'AnimatedPadding基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子组件   【Widget】\n"
//          "【duration】 : 动画时长   【Duration】\n"
//          "【onEnd】 : 动画结束回调   【Function()】\n"
//          "【curve】 : 动画曲线   【Duration】\n"
//          "【padding】 : 内边距   【EdgeInsetsGeometry】",
//    }
class CustomAnimatedPadding extends StatefulWidget {
  const CustomAnimatedPadding({Key? key}) : super(key: key);

  @override
  _CustomAnimatedPaddingState createState() => _CustomAnimatedPaddingState();
}

class _CustomAnimatedPaddingState extends State<CustomAnimatedPadding> {
  final EdgeInsets startPadding = const EdgeInsets.all(10);
  final EdgeInsets endPadding = const EdgeInsets.all(30);

  late EdgeInsets _padding;

  @override
  void initState() {
    _padding = startPadding;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Switch(
            value: _padding == endPadding,
            onChanged: (v) {
              setState(() {
                _padding = v ? endPadding : startPadding;
              });
            }),
        Container(
          color: Colors.grey.withAlpha(22),
          width: 200,
          height: 100,
          child: AnimatedPadding(
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            padding: _padding,
            onEnd: () => print('End'),
            child: Container(
              alignment: Alignment.center,
              color: Colors.blue,
              child: const Text(
                '张风捷特烈',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
