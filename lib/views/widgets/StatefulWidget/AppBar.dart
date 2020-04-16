import 'package:flutter/material.dart';
import 'PopupMenuButton.dart';

//    {
//      "widgetId": 57,
//      "name": 'AppBar基本使用',
//      "priority": 1,
//      "subtitle":
//          "【leading】 : 左侧组件   【Widget】\n"
//          "【title】 : 中间组件   【Widget】\n"
//          "【actions】 : 右侧组件   【List<Widget>】\n"
//          "【elevation】 : 影深   【double】\n"
//          "【shape】 : 形状   【ShapeBorder】\n"
//          "【backgroundColor】 : 影深   【背景色】\n"
//          "【centerTitle】 : 中间是否居中   【bool】",
//    }

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('风雅六社'),
      leading: BackButton(),
      backgroundColor: Colors.amber[500],
      elevation: 2,
      centerTitle: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
        topRight: Radius.circular(5),
        bottomLeft: Radius.circular(5),
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
    );
  }
}

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
                    "assets/images/sabar.jpg",
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
