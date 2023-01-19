import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/11
/// contact me by email 1981462002@qq.com
///
/// 说明: 213 HtmlElementView 0 在 Flutter Web 的 Widget 层次结构中嵌入一个 HTML 元素。
//    {
//      "widgetId": 213,
//      "name": 'HtmlElementView 介绍',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 子组件   【child】\n"
//          "【viewType】 : html元素唯一表识   【String】",
//    }
class HtmlElementViewDemo extends StatelessWidget {
  const HtmlElementViewDemo({Key? key}) : super(key: key);

  final String info =
      '该组件只能用于 Flutter Web 中，嵌入 Html 元素的较为昂贵。'
      '内部基于 PlatformViewLink 和 PlatformViewSurface 组件实现。';


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.withOpacity(0.1),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Text(info),
    );
  }
}
