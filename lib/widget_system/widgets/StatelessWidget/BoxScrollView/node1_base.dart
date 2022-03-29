import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 350 BoxScrollView 盒滑动视图
/// BoxScrollView 类是一个继承自 ScrollView 的抽象类，所以无法直接使用，它的子类有 ListView、GridView。一般不自己实现子类使用它。
/// link 183,162,163
///
//    {
//      "widgetId": 350,
//      "name": 'BoxScrollView 介绍',
//      "priority": 1,
//      "subtitle":
//          "【reverse】 : 是否反向   【bool】\n"
//          "【scrollDirection】 : 滑动方向   【Axis】\n"
//          "【cacheExtent】 : 缓存长   【double】\n"
//          "【dragStartBehavior】 : 拖动行为   【DragStartBehavior】\n"
//          "【clipBehavior】 : 裁剪行为   【ClipBehavior】\n"
//          "【controller】 : 控制器   【ScrollController】",
//    }

class BoxScrollViewDemo extends StatelessWidget {
  const BoxScrollViewDemo({Key? key}) : super(key: key);

  final String info =
      'BoxScrollView 是 ScrollView 的子类，实现了它的抽象方法，且暴露出另一个抽象方法 buildChildLayout，返回 Sliver 家族 Widget，'
      '其子类有 ListView 和 GridView，分别使用 Sliver 家族相关List、Gird列表组件实现的。';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          Container(
            color: Colors.blue.withOpacity(0.1),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            child: Text(info),
          ),
          Expanded(child: MyBoxScrollView()),
        ],
      ),
    );
  }
}

class MyBoxScrollView extends BoxScrollView {
  MyBoxScrollView({Key? key}) : super(key: key);

  final List<Color> data = [
    Colors.purple[50]!,
    Colors.purple[100]!,
    Colors.purple[200]!,
    Colors.purple[300]!,
    Colors.purple[400]!,
    Colors.purple[500]!,
    Colors.purple[600]!,
    Colors.purple[700]!,
    Colors.purple[800]!,
    Colors.purple[900]!,
  ];

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";

  @override
  Widget buildChildLayout(BuildContext context)=> SliverFixedExtentList(
    itemExtent: 60,
    delegate: SliverChildBuilderDelegate(
            (_, int index) => Container(
          alignment: Alignment.center,
                  width: 100,
                  height: 50,
                  color: data[index],
                  child: Text(
                    colorString(data[index]),
                    style: const TextStyle(color: Colors.white, shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(.5, .5),
                          blurRadius: 2)
                    ]),
                  ),
                ),
        childCount: data.length),
  );
}
