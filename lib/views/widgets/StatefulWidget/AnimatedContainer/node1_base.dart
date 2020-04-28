import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-23
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 123,
//      "name": 'AnimatedContainer基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子组件   【Widget】\n"
//          "【duration】 : 动画时长   【Duration】\n"
//          "【onEnd】 : 动画结束回调   【Function()】\n"
//          "【curve】 : 动画曲线   【Duration】\n"
//          "【color】 : 颜色   【Color】\n"
//          "【width】 : 宽   【double】\n"
//          "【height】 : 高   【double】\n"
//          "【alignment】 : 对齐   【AlignmentGeometry】\n"
//          "【decoration】 : 装饰   【Decoration】\n"
//          "【constraints】 : 约束   【BoxConstraints】\n"
//          "【transform】 : 变化   【Matrix4】\n"
//          "【margin】 : 外边距   【EdgeInsetsGeometry】\n"
//          "【padding】 : 内边距   【EdgeInsetsGeometry】",
//    }
class CustomAnimatedContainer extends StatefulWidget {
  @override
  _CustomAnimatedContainerState createState() =>
      _CustomAnimatedContainerState();
}

class _CustomAnimatedContainerState extends State<CustomAnimatedContainer> {
  final Decoration startDecoration = BoxDecoration(
      color: Colors.blue,
      image: DecorationImage(
          image: AssetImage('assets/images/wy_200x300.jpg'), fit: BoxFit.cover),
      borderRadius: BorderRadius.all(Radius.circular(20)));
  final Decoration endDecoration = BoxDecoration(
      image: DecorationImage(
          image: AssetImage('assets/images/wy_200x300.jpg'), fit: BoxFit.cover),
      color: Colors.orange,
      borderRadius: BorderRadius.all(Radius.circular(50)));

  final Alignment startAlignment = Alignment(0, 0);
  final Alignment endAlignment = Alignment.topLeft + Alignment(0.2, 0.2);

  final startHeight = 100.0;
  final endHeight = 50.0;

  Decoration _decoration;
  double _height;
  Alignment _alignment;

  @override
  void initState() {
    _decoration = startDecoration;
    _height = startHeight;
    _alignment=startAlignment;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildSwitch(),
        AnimatedContainer(
          duration: Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          alignment: _alignment,
          color: Colors.grey.withAlpha(22),
          width: 200,
          height: 120,
          child: UnconstrainedBox(
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              decoration: _decoration,
              onEnd: () => print('End'),
              height: _height,
              width: _height,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitch() => Switch(
          value: _height == endHeight,
          onChanged: (v) {
            setState(() {
              _height = v ? endHeight : startHeight;
              _decoration = v ? endDecoration : startDecoration;
              _alignment = v ? endAlignment : startAlignment;
            });
          });
}
