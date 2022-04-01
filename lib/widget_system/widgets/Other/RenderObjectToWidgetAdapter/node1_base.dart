
import 'package:flutter/material.dart';


/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 289 RenderObjectToWidgetAdapter 根组件 RenderObject 和 Element 树的桥梁。
///
//    {
//      "widgetId": 289,
//      "name": 'RenderObjectToWidgetAdapter 介绍',
//      "priority": 1,
//      "subtitle": "【container】 : 渲染对象   【RenderObjectWithChildMixin<T>】\n"
//          "【child】 : 子组件   【Widget】\n"
//          "【debugShortDescription】 : 调试简介   【String】",
//    }

class RenderObjectToWidgetAdapterDemo extends StatelessWidget {
  const RenderObjectToWidgetAdapterDemo({Key? key}) : super(key: key);

  final String info =
      '该组件并没有什么太大的使用价值，但却非常有纪念意义。它是 Flutter 框架中最顶层的 Widget，它的 child 是 runApp 传入的组件，在 attachRootWidget 方法中被实例化。'
      '它持有根渲染对象 RenderView ，负责创建根元素 RenderObjectToWidgetElement，是一个无名英雄，一个深藏功与名的组件。';

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
