import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-01
/// contact me by email 1981462002@qq.com
/// 说明: 212 ModalBarrier 屏障模
/// 相当于一块幕布，防止用户与其背后的 Widget 交互，可以通过 dismissible 决定点击时，是否触发返回栈。源码中用于 Dialog 相关组件。
/// link: 227,126,127,128
//    {
//      "widgetId": 212,
//      "name": 'ModalBarrier 介绍',
//      "priority": 1,
//      "subtitle":
//          "【dismissible】 : 点击是否返回   【bool】\n"
//          "【color】 : 颜色   【Color】",
//    }
class ModalBarrierDemo extends StatelessWidget {
  const ModalBarrierDemo({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 100,
      child: Stack(alignment: Alignment.center, children: [
        ModalBarrier(
          dismissible: true,
          color: Colors.grey.withOpacity(0.3),
        ),
        const Text('点击背景返回')
      ]),
    );
  }
}
