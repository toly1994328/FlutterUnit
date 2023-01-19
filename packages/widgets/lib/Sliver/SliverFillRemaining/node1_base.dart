import 'dart:math';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 306 SliverFillRemaining Sliver填补剩余 一个包含单个box子元素的sliver，它填充了视窗中的剩余空间。
//    {
//      "widgetId": 306,
//      "name": 'SliverFillRemaining基本使用',
//      "priority": 1,
//      "subtitle": "【hasScrollBody】 : 是否具有滚动主体   【bool】\n"
//          "【fillOverscroll】 : 是否可填充滚动区域   【bool】\n"
//          "【child】 : 子组件   【Widget】",
//    }
class SliverFillRemainingDemo extends StatefulWidget {
  const SliverFillRemainingDemo({Key? key}) : super(key: key);

  @override
  _SliverFillRemainingDemoState createState() =>
      _SliverFillRemainingDemoState();
}

class _SliverFillRemainingDemoState extends State<SliverFillRemainingDemo> {
  final List<Color> data = [
    Colors.orange[50]!,
    Colors.orange[100]!,
    Colors.orange[200]!,
    Colors.orange[300]!,
    Colors.orange[400]!,
    Colors.orange[500]!,
    Colors.orange[600]!,
    Colors.orange[700]!,
    Colors.orange[800]!,
    Colors.orange[900]!,
  ];

  final Random r = Random();

  bool hasScrollBody = false;
  bool fillOverscroll = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          _buildSliverAppBar(),
          _buildSliverList(),
          SliverFillRemaining(
            hasScrollBody: hasScrollBody,
            fillOverscroll: fillOverscroll,
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/sabar_bar.webp"))),
              // // color: Colors.teal[100],
              child: _buildBottomChild(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomChild() => Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            spacing: 10,
            children: [
              ElevatedButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  setState(() {
                    hasScrollBody = !hasScrollBody;
                  });
                },
                child: Text('hasScrollBody:$hasScrollBody',style: const TextStyle(color: Colors.white),),
              ),
              ElevatedButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  setState(() {
                    fillOverscroll = !fillOverscroll;
                  });
                },
                child: Text('fillOverscroll:$fillOverscroll',style: const TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      );

  Widget _buildSliverList() => SliverFixedExtentList(
        itemExtent: 50,
        delegate: SliverChildBuilderDelegate(
            (_, int index) => Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 60,
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

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 120.0,
      leading: Container(
          margin: const EdgeInsets.all(10),
          child: Image.asset('assets/images/icon_head.webp')),
      title: const Text('张风捷特烈'),
      actions: _buildActions(),
      elevation: 5,
      pinned: true,
      backgroundColor: Colors.orange,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 55, bottom: 15), //标题边距
        collapseMode: CollapseMode.parallax, //视差效果
        background: Image.asset(
          "assets/images/caver.webp",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  List<Widget> _buildActions() => <Widget>[
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.star_border,
            color: Colors.white,
          ),
        )
      ];

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";

}
