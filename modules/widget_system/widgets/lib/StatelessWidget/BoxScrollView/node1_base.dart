import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com


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
