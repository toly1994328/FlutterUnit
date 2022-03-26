import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 348 SliverWithKeepAliveWidget Sliver保活容器
/// 它是抽象类，不能单独使用。只有其子类才可以容纳 KeepAlive 的孩子。
/// link 316,239,188,185,314,186
///
//    {
//      "widgetId": 348,
//      "name": 'SliverWithKeepAliveWidget 介绍',
//      "priority": 1,
//      "subtitle":
//          "【key】 : 键   【Key】",
//    }


class SliverWithKeepAliveWidgetDemo extends StatelessWidget {
  const SliverWithKeepAliveWidgetDemo({Key? key}) : super(key: key);

  final String info =
      '只有 SliverWithKeepAliveWidget 之下才可以包含 KeepAlive 组件, 由于其为抽象类，不能直接使用。其子类 SliverMultiBoxAdaptorWidget 也说抽象类，'
      '用于容纳多个孩子，帮助它的子类使用 SliverChildDelegate 构建懒加载 children。'
      '最终实现类为 SliverGrid、SliverList、SliverPrototypeExtentList、SliverFixedExtentList，表示他们都可以支持 item 的状态保持。'
      '除此之外还有 _SliverFillViewportRenderObjectWidget 的私有实现类，这是 PageView 的底层实现，这也是为什么 PageView 也支持保活的原因。';

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Text(info),
    );
  }
}