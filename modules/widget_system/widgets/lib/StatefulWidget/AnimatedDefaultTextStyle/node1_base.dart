import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-23
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 124,
//      "name": 'AnimatedDefaultTextStyle基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子组件   【Widget】\n"
//          "【duration】 : 动画时长   【Duration】\n"
//          "【onEnd】 : 动画结束回调   【Function()】\n"
//          "【curve】 : 动画曲线   【Duration】\n"
//          "【textAlign】 : 文字对齐方式  【TextAlign】\n"
//          "【softWrap】 : 是否包裹  【bool】\n"
//          "【maxLines】 : 最大行数  【int】\n"
//          "【overflow】 : 溢出模式  【TextOverflow】\n"
//          "【style】 : 文字样式   【TextStyle】",
//    }
class CustomAnimatedDefaultTextStyle extends StatefulWidget {
  const CustomAnimatedDefaultTextStyle({Key? key}) : super(key: key);

  @override
  _CustomAnimatedDefaultTextStyleState createState() =>
      _CustomAnimatedDefaultTextStyleState();
}

class _CustomAnimatedDefaultTextStyleState
    extends State<CustomAnimatedDefaultTextStyle> {
  final TextStyle start = const TextStyle(
      color: Colors.blue,
      fontSize: 50,
      shadows: [
        Shadow(offset: Offset(1, 1), color: Colors.black, blurRadius: 3)
      ]);
  final TextStyle end = const TextStyle(
      color: Colors.white,
      fontSize: 20,
      shadows: [
        Shadow(offset: Offset(1, 1), color: Colors.purple, blurRadius: 3)
      ]);

  late TextStyle _style;

  @override
  void initState() {
    _style = start;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildSwitch(),
        Container(
          alignment: Alignment.center,
          color: Colors.grey.withAlpha(22),
          width: 300,
          height: 100,
          child: AnimatedDefaultTextStyle(
            textAlign: TextAlign.start,
            softWrap: true,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            style: _style,
            onEnd: () => print('End'),
            child: const Text(
              '张风捷特烈',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitch() => Switch(
      value: _style == end,
      onChanged: (v) {
        setState(() {
          _style = v ? end : start;
        });
      });
}
