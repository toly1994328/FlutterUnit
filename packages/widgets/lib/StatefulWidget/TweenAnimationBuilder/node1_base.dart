
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 226 TweenAnimationBuilder 渐变动画构造器
/// 通过渐变器 Tween 对相关属性进行渐变动画，通过 builder 进行局部构建，减少刷新范围。不需要自定义动画器，可指定动画时长、曲线、结束回调。
///
//    {
//      "widgetId": 226,
//      "name": 'TweenAnimationBuilder 使用案例',
//      "priority": 1,
//      "subtitle":
//          "【tween】 : *渐变器   【Tween<T>】\n"
//          "【duration】 : *时长   【Duration】\n"
//          "【builder】 : *构造器   【ValueWidgetBuilder<T>】\n"
//          "【curve】 : 动画曲线   【Curve】\n"
//          "【onEnd】 : 结束回调   【VoidCallback】\n"
//          "【child】 : 子组件   【Widget】",
//    }

class TweenAnimationBuilderDemo extends StatefulWidget {
  const TweenAnimationBuilderDemo({Key? key}) : super(key: key);

  @override
  _TweenAnimationBuilderDemoState createState() =>
      _TweenAnimationBuilderDemoState();
}

class _TweenAnimationBuilderDemoState extends State<TweenAnimationBuilderDemo> {
  Color _value = Colors.red;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: ColorTween(begin: Colors.blue, end: _value),
      duration: const Duration(milliseconds: 800),
      builder: (BuildContext context, Color? color, Widget? child) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _value = _value == Colors.red ? Colors.blue : Colors.red;
            });
          },
          child: Container(
            width: 40,
            height: 40,
            child: child,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(5)
            ),
          ),
        );
      },
      child: const Icon(
        Icons.android_outlined,
        color: Colors.white,
      ),
    );
  }
}
