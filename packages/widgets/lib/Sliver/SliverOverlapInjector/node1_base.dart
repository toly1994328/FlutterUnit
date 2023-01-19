import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/6/16
/// contact me by email 1981462002@qq.com
/// 说明: 

//    {
//      "widgetId": 308,
//      "name": 'SliverOverlapInjector基本使用',
//      "priority": 1,
//      "subtitle": "【sliver】 : 子组件   【Widget】\n"
//          "【handle】 : *处理器   【SliverOverlapAbsorberHandle】\n"
//          "如果不使用SliverOverlapAbsorber和SliverOverlapInjector组件,NestedScrollView的内容会和头部栏重叠。",
//    }

class SliverOverlapInjectorDemo extends StatelessWidget {
  const SliverOverlapInjectorDemo({Key? key}) : super(key: key);

  final List<String> _tabs = const ['风神传', '封妖志', "幻将录", "永恒传说"];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 200,
        child: Scaffold(
          body: DefaultTabController(
            length: _tabs.length,
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                    sliver: SliverAppBar(
                      title: const Text('旷古奇书'),
                      pinned: true,
                      elevation: 6, //影深
                      expandedHeight: 220.0,
                      forceElevated: innerBoxIsScrolled, //为true时展开有阴影
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.asset(
                          "assets/images/wy_300x200_filter.webp",
                          fit: BoxFit.cover,
                        ),
                      ),
                      bottom: TabBar(
                        tabs: _tabs
                            .map((String name) => Tab(text: name,))
                            .toList(),
                      ),
                    ),
                  ),
                ];
              },
              body: _buildTabBarView(),
            ),
          ),
        ));
  }

  Widget _buildTabBarView() {
    return TabBarView(
      children: _tabs.map((String name) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Builder(
            builder: (BuildContext context) {
              return CustomScrollView(
                key: PageStorageKey<String>(name),
                slivers: <Widget>[
                  SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                  ),
                  buildContent(name),
                ],
              );
            },
          ),
        );
      }).toList(),
    );
  }

  Widget buildContent(String name) => SliverPadding(
        padding: const EdgeInsets.all(8.0),
        sliver: SliverFixedExtentList(
          itemExtent: 48.0,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ListTile(
                title: Text('《$name》 第 $index章'),
              );
            },
            childCount: 50,
          ),
        ),
      );
}
