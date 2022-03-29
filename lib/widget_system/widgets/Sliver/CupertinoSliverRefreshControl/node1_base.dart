import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 303 CupertinoSliverRefreshControl Sliver刷新控制器 iOS风格的下拉刷新控制器，可执行异步刷新方法、自定义控制器组件、指示器停留高度和触发加载的滑动高度。
//    {
//      "widgetId": 303,
//      "name": '刷新控制器基本使用',
//      "priority": 1,
//      "subtitle":
//          "【refreshIndicatorExtent】 : 加载中指示器高度   【double】\n"
//          "【refreshTriggerPullDistance】 : 触发加载的滑动高度   【double】\n"
//          "【onRefresh】 : 下拉事件   【RefreshCallback】\n"
//          "【builder】 : 指示器构造器   【RefreshControlIndicatorBuilder】",
//    }
class CupertinoSliverRefreshControlDemo extends StatefulWidget {
  const CupertinoSliverRefreshControlDemo({Key? key}) : super(key: key);

  @override
  _CupertinoSliverRefreshControlDemoState createState() =>
      _CupertinoSliverRefreshControlDemoState();
}

class _CupertinoSliverRefreshControlDemoState
    extends State<CupertinoSliverRefreshControlDemo> {
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          _buildSliverAppBar(),
          CupertinoSliverRefreshControl(
            refreshIndicatorExtent: 60,
            refreshTriggerPullDistance: 80,
            onRefresh: _doRefresh,
          ),
          _buildSliverList()
        ],
      ),
    );
  }

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

  Color randomColor() => Color.fromARGB(
      r.nextInt(255), r.nextInt(255), r.nextInt(255), r.nextInt(255));

  Future<void> _doRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      data.insertAll(0, [randomColor()]);
    });
  }
}
