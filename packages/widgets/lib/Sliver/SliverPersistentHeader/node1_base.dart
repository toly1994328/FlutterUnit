import 'dart:math';

import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-31
/// contact me by email 1981462002@qq.com
/// 说明: 
//    {
//      "widgetId": 190,
//      "name": 'SliverPersistentHeader基本使用',
//      "priority": 1,
//      "subtitle":
//          "【delegate】 : 代理   【SliverPersistentHeaderDelegate】\n"
//          "【floating】 : 是否浮动   【bool】\n"
//          "【pinned】 : 是否顶部停留   【bool】",
//    }
class SliverPersistentHeaderDemo extends StatelessWidget {
  SliverPersistentHeaderDemo({Key? key}) : super(key: key);

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
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: CustomScrollView(
        slivers: <Widget>[
          _buildSliverAppBar(),
          _buildPersistentHeader('袅缈岁月，青丝银发',const Color(0xffe7fcc9)),
          _buildCommonWidget(),
          _buildPersistentHeader('以梦为马，不负韶华',const Color(0xffcca4ff)),
          _buildSliverList()
        ],
      ),
    );
  }

  Widget _buildCommonWidget() => SliverToBoxAdapter(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.grey.withAlpha(22),
      child: ListTile(
        leading: Image.asset("assets/images/icon_head.webp"),
        title: const Text("以梦为马"),
        subtitle: const Text("海子"),
        selected: true,
        contentPadding: const EdgeInsets.all(5),
        trailing: const Icon(Icons.more_vert),
      ),
    ),
  );
  Widget _buildPersistentHeader(String text,Color color) => SliverPersistentHeader(
    pinned: true,
    delegate: _SliverDelegate(
        minHeight: 40.0,
        maxHeight: 100.0,
        child: Container(
          color: color,
          child: Center(
            child: Text(text, style: const TextStyle(
                fontSize: 18,
                shadows: [Shadow(color: Colors.white, offset: Offset(1, 1))]),
          ),
        )),
  ));

  Widget _buildSliverList() => SliverList(
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
      expandedHeight: 190.0,
      leading: _buildLeading(),
      title: const Text('张风捷特烈'),
      actions: _buildActions(),
      elevation: 2,
      pinned: true,
      backgroundColor: Colors.orange,
      flexibleSpace: FlexibleSpaceBar(
        //伸展处布局
        titlePadding: const EdgeInsets.only(left: 55, bottom: 15), //标题边距
        collapseMode: CollapseMode.parallax, //视差效果
        background: Image.asset(
          "assets/images/caver.webp",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildLeading() => Container(
      margin: const EdgeInsets.all(10),
      child: Image.asset('assets/images/icon_head.webp'));

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


class _SliverDelegate extends SliverPersistentHeaderDelegate {
  _SliverDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight; //最小高度
  final double maxHeight; //最大高度
  final Widget child; //孩子

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override //是否需要重建
  bool shouldRebuild(_SliverDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}