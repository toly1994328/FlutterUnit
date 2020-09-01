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
  @override
  _TabAppBarState createState() => _TabAppBarState();
}

class _TabAppBarState extends State<TabAppBar>
    with SingleTickerProviderStateMixin {
  final tabs = ['风画庭', '雨韵舍', '雷鸣殿', '电疾堂', '霜寒阁', '雪月楼'];
  TabController _tabController;

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
    return Column(
      children: <Widget>[
        Container(
          height: 180,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/sabar.webp",
                  ),
                  fit: BoxFit.cover)),
          child: _buildAppBar(),
        ),
        Container(
            height: 150, color: Color(0xff916BF0), child: _buildTableBarView())
      ],
    );
  }

  Widget _buildAppBar() => AppBar(
        title: Text('风雅六社'),
        elevation: 1,
        leading: BackButton(),
        backgroundColor: Colors.amber[500].withAlpha(33),
        centerTitle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.star),
              tooltip: 'like',
              onPressed: () {
                // do nothing
              }),
          CustomPopupMenuButton()
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
          .map((e) => Center(
                  child: Text(
                e,
                style: TextStyle(color: Colors.white, fontSize: 20),
              )))
          .toList());
}
