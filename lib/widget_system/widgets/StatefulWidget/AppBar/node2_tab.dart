import 'package:flutter/material.dart';

import '../PopupMenuButton/node1_base.dart';
/// create by 张风捷特烈 on 2020-03-23
/// contact me by email 1981462002@qq.com
/// 详情:
//    {
//      "widgetId": 57,
//      "name": 'AppBar与TabBar、TabBarView联用',
//      "priority": 2,
//      "subtitle":
//          "【bottom】 : 底部组件   【PreferredSizeWidget】",
//    }
class TabAppBar extends StatefulWidget {
  const TabAppBar({Key? key}) : super(key: key);

  @override
  _TabAppBarState createState() => _TabAppBarState();
}

class _TabAppBarState extends State<TabAppBar>
    with SingleTickerProviderStateMixin {
  final List<String> tabs = ['风画庭', '雨韵舍', '雷鸣殿', '电疾堂', '霜寒阁', '雪月楼'];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildTableBarView(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() => AppBar(
        title: const Text('风雅六社'),
        elevation: 1,
        leading: const BackButton(),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.star),
              tooltip: 'liked_widget_bloc',
              onPressed: () {
                // do nothing
              }),
          const CustomPopupMenuButton()
        ],
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          indicatorColor: Colors.orangeAccent,
          tabs: tabs.map((e) => Tab(text: e)).toList(),
        ),
      );

  Widget _buildTableBarView() => TabBarView(
      controller: _tabController,
      children: tabs
          .map((e) => ColoredBox(
          color: Colors.purple,
          child:Center(
                  child:  Text(
                      e,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
                  )))
          .toList());
}
