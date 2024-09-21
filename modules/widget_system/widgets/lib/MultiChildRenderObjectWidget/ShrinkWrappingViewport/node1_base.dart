import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com


class ShrinkWrappingViewportDemo extends StatelessWidget {

  const ShrinkWrappingViewportDemo({Key? key}) : super(key: key);

  final String info =
      'ShrinkWrappingViewport 在源码中只有一处使用：'
      '在 ScrollView 中如果 shrinkWrap 为 true，会使用 ShrinkWrappingViewport，该属性在其子类 ListView、GridView、CustomScrollView 中可指定。'
      '如果 shrinkWrap 为 false，视口会使用 Viewport，此时，视图区域将会沿滑动方向尽可能延伸。在无边界约束的情况下，shrinkWrap 需要是 true。'
      '另外 ShrinkWrappingViewport 使用比较昂贵，因为滑动时需要重新计算滑动视图的尺寸。';

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
