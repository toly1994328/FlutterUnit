import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/3/31
/// contact me by email 1981462002@qq.com
///
/// 说明: 335 PrimaryScrollController 5 初始滑动控制器 它是 InheritedWidget 子类，通过 context 向子树中的可滑动视图提供默认的 ScrollController 对象。
//    {
//      "widgetId": 335,
//      "name": 'PrimaryScrollController 介绍',
//      "priority": 1,
//      "subtitle": "【controller】 : 滑动控制器   【ScrollController】\n"
//          "【child】 : 子组件   【Widget】",
//    }
class PrimaryScrollControllerDemo extends StatelessWidget {
  const PrimaryScrollControllerDemo({Key? key}) : super(key: key);

  final String info =
      'PrimaryScrollController 是 InheritedWidget 子类，也就说明它可以为子树组件提供某些默认数据，'
      '子树可以通过 context 来获取上层该组件的提供 ScrollController 对象。\n'
      '对于一些可滑动组件 ScrollView、SingleChildScrollView、NestedScrollView 等，'
      '在使用者未提供 ScrollController 时，且 primary 属性为 true 时(默认true) ，'
      '会使用上层 PrimaryScrollController 组件提供的滑动控制器。\n'
      '使用 MaterialApp 组件，其已经内置 PrimaryScrollController，';

  @override
  Widget build(BuildContext context) {
    ScrollController? label = PrimaryScrollController.of(context);

    return Container(
      color: Colors.blue.withOpacity(0.1),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Text(info+"当前其持有的滑动控制器对象: $label"),
    );
  }
}
