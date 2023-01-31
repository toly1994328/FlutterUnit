import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 347 ParentDataWidget 父数据组件
/// 抽象类，用于将 ParentData 信息挂钩到 RenderObjectWidget 子组件上。其子类有 Positioned、Flexible、Expanded等，这些组件只能用于特定的组件之下。
///
//    {
//      "widgetId": 347,
//      "name": 'ParentDataWidget 介绍',
//      "priority": 1,
//      "subtitle": "【child】 : 子组件   【Widget】",
//    }

class ParentDataWidgetDemo extends StatelessWidget {
  const ParentDataWidgetDemo({Key? key}) : super(key: key);

  final String info =
      'ParentDataWidget 是一个抽象类，不能直接使用，它拥有 ParentData 子类型的泛型，该泛型会限定该组件的适应场景。'
      '如 Positioned 组件继承自 ParentDataWidget<StackParentData>，就说明 Positioned 的上层组件必须使用 Stack 族组件。'
      '如 Flexible 组件继承自 ParentDataWidget<FlexParentData>，就说明 Flexible 的上层组件必须使用 Flex 族组件。';

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
