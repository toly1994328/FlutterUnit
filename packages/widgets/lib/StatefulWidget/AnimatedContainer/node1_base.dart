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
  const CustomAnimatedContainer({Key? key}) : super(key: key);

  @override
  _CustomAnimatedContainerState createState() =>
      _CustomAnimatedContainerState();
}

class _CustomAnimatedContainerState extends State<CustomAnimatedContainer> {
  final Decoration startDecoration = const BoxDecoration(
      color: Colors.deepPurple,
      borderRadius: BorderRadius.all(Radius.circular(30)),
      boxShadow: [
        BoxShadow(
            offset: Offset(1, 1),
            color: Colors.purple,
            blurRadius: 5,
            spreadRadius: 2)
      ]);
  final Decoration endDecoration = const BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      boxShadow: [
        BoxShadow(
            offset: Offset(1, 1),
            color: Colors.blue,
            blurRadius: 10,
            spreadRadius: 0)
      ]);

  final Alignment startAlignment = Alignment.topLeft + const Alignment(0.2, 0.2);
  final Alignment endAlignment = Alignment.center;

  final double startHeight = 150.0;
  final double endHeight = 100.0;

  late Decoration _decoration;
  late double _height;
  late Alignment _alignment;

  @override
  void initState() {
    super.initState();
    _decoration = startDecoration;
    _height = startHeight;
    _alignment = startAlignment;
  }

  bool get selected => _height == endHeight;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Switch(
          value: selected,
          onChanged: onChanged,
        ),
        buildAnim()
      ],
    );
  }
  Widget _buildChild() => const Icon(
    Icons.camera_outlined,
    size: 30,
    color: Colors.white,
  );
  Widget buildAnim() => AnimatedContainer(
    duration: const Duration(seconds: 1),
    curve: Curves.fastOutSlowIn,
    decoration: _decoration,
    alignment: _alignment,
    onEnd: onEnd,
    height: _height,
    width: _height,
    child: _buildChild(),
  );
  void onChanged(bool value) {
    setState(() {
      _height = value ? endHeight : startHeight;
      _decoration = value ? endDecoration : startDecoration;
      _alignment = value ? endAlignment : startAlignment;
    });
  }
  void onEnd() {
    print('End');
  }
}
