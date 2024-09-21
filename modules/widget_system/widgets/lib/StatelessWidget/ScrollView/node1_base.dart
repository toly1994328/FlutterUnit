import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com


class ScrollViewDemo extends StatelessWidget {
  const ScrollViewDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: MyScrollView(),
    );
  }
}

class MyScrollView extends ScrollView {
  MyScrollView({Key? key}) : super(key: key);

  final String info =
      'ScrollView 其内部依靠 Viewport + Scrollable 实现滑动。它只有一个 buildSlivers 的抽象方法，返回 Sliver 家族 Widget 列表，'
      '其子类最简单的是 CustomScrollView，将 slivers 交由用户传递，自身打个酱油。'
      'ListView 和 GridView 在底层源码中也是使用 Sliver 家族相关组件实现的。';

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

  @override
  List<Widget> buildSlivers(BuildContext context) {
    return [
      _buildSliverAppBar(),
      SliverToBoxAdapter(
        child: Container(
          color: Colors.blue.withOpacity(0.1),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          child: Text(info),
        ),
      ),
      _buildSliverFixedExtentList()
    ];
  }

  _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 190.0,
      leading: Container(
          margin: const EdgeInsets.all(10),
          child: Image.asset('assets/images/icon_head.webp')),
      flexibleSpace: FlexibleSpaceBar(//伸展处布局
        titlePadding: const EdgeInsets.only(left: 55, bottom: 15), //标题边距
        collapseMode: CollapseMode.parallax, //视差效果
        title: const Text(
          '张风捷特烈',
          style: TextStyle(color: Colors.black, //标题
              shadows: [
                Shadow(color: Colors.blue, offset: Offset(1, 1), blurRadius: 2)
              ]),
        ),
        background: Image.asset(
          "assets/images/caver.webp",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildSliverFixedExtentList() => SliverFixedExtentList(
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

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}
