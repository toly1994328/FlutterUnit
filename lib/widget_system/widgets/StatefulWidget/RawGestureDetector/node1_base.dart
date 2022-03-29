
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 248 RawGestureDetector  可以用来检测给定手势工厂描述的手势，在开发自己的手势识别器时非常有用。对于常见的手势，使用 GestureRecognizer。
//    {
//      "widgetId": 248,
//      "name": 'RawGestureDetector基本使用',
//      "priority": 1,
//      "subtitle":
//          "【behavior】 : 侦测行为   【HitTestBehavior】\n"
//          "【gestures】 : 手势映射   【Map<Type, GestureRecognizerFactory>】\n"
//          "【child】 : 子组件   【Widget】",
//    }

class RawGestureDetectorDemo extends StatefulWidget {
  const RawGestureDetectorDemo({Key? key}) : super(key: key);

  @override
  _RawGestureDetectorDemoState createState() => _RawGestureDetectorDemoState();
}

class _RawGestureDetectorDemoState extends State<RawGestureDetectorDemo> {
  String _last = "";

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        TapGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
          () => TapGestureRecognizer(),
          init,
        ),
      },
      child: Container(
          width: 300.0,
          height: 100.0,
          alignment: Alignment.center,
          color: Colors.yellow,
          child: Text(_last)),
    );
  }

  void init(TapGestureRecognizer instance) {
    instance..onTapDown = (TapDownDetails details) {
        setState(() {
          _last = 'down';
        });
      }
      ..onTapUp = (TapUpDetails details) {
        setState(() {
          _last = 'up';
        });
      }
      ..onTap = () {
        setState(() {
          _last = 'tap';
        });
      }
      ..onTapCancel = () {
        setState(() {
          _last = 'cancel';
        });
      }
      ;
  }
}
