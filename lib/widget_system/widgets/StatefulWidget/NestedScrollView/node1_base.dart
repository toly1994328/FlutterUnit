import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/6/16
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 251,
//      "name": 'NestedScrollView基本用法',
//      "priority": 1,
//      "subtitle":
//          "【controller】 : 滑动控制器   【ScrollController】\n"
//          "【scrollDirection】 : 滑动方向   【Axis】\n"
//          "【reverse】 : 是否反向   【bool】\n"
//          "【physics】 : 滑顶样式   【ScrollPhysics】\n"
//          "【dragStartBehavior】 : 开始拖动行为   【DragStartBehavior】\n"
//          "【headerSliverBuilder】 : *头部构造器   【NestedScrollViewHeaderSliversBuilder】\n"
//          "【body】 : *内容   【Widget】",
//    }

class NestedScrollViewDemo extends StatelessWidget {
  final List<String> _tabs = const ['风神传', '封妖志', "幻将录", "永恒传说"];

  const NestedScrollViewDemo({Key? key}) : super(key: key);

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
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  ),
                  SliverPadding(
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
                  ),
                ],
              );
            },
          ),
        );
      }).toList(),
    );
  }
}
