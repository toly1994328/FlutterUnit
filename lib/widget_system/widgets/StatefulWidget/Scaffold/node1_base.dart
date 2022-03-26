import 'package:flutter/material.dart';
import '../PopupMenuButton/node1_base.dart';
/// create by 张风捷特烈 on 2020/4/30
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 64,
//      "name": 'Scaffold基本用法',
//      "priority": 1,
//      "subtitle":
//          "【appBar】 : 头部组件   【PreferredSizeWidget】\n"
//          "【bottomNavigationBar】 : 底部组件   【Widget】\n"
//          "【drawer】 : 左侧滑组件   【Widget】\n"
//          "【endDrawer】 : 右侧滑组件   【Widget】\n"
//          "【body】 : 内容组件   【Widget】\n"
//          "【backgroundColor】 : 背景色   【Color】\n"
//          "【floatingActionButton】 : 浮动按钮   【Widget】\n"
//          "【floatingActionButtonLocation】 : 浮动按钮位置   【FloatingActionButtonLocation】",
//    }
class CustomScaffold extends StatefulWidget {
  const CustomScaffold({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomScaffoldState();
}

// AppBar 默认的实例,有状态
class _CustomScaffoldState extends State with SingleTickerProviderStateMixin {
  final List<String> tabs = const ['风画庭', '雨韵舍', '雷鸣殿', '电疾堂', '霜寒阁', '雪月楼'];
  int _position = 0;
  final Map<String,IconData> iconsMap = {
    "图鉴": Icons.home,
    "动态": Icons.toys,
    "喜欢": Icons.favorite,
    "手册": Icons.class_,
    "我的": Icons.account_circle,
  };
  final List<Color> _colors = [
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.purple,
  ];

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
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 300,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {},
        ),
        drawer: _buildLeftDrawer(),
        endDrawer: _buildLeftDrawer(),
        appBar: AppBar(
          title: const Text('风雅六社'),
          backgroundColor: Colors.blue,
          centerTitle: true,
          actions: const [Icon(Icons.star), CustomPopupMenuButton()],
          bottom: _buildTabBar(),
        ),
        body: _buildTableBarView(),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Drawer _buildLeftDrawer() => Drawer(
        elevation: 1,
        child: Image.asset(
          'assets/images/sabar.webp',
          fit: BoxFit.cover,
        ),
      );

  PreferredSizeWidget _buildTabBar() => TabBar(
        isScrollable: true,
        controller: _tabController,
        indicatorColor: Colors.orangeAccent,
        tabs: tabs.map((e) => Tab(text: e)).toList(),
      );

  Widget _buildBottomNavigationBar() => BottomNavigationBar(
        onTap: (position) => setState(() => _position = position),
        currentIndex: _position,
        elevation: 1,
        backgroundColor: Colors.white,
        iconSize: 25,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        showUnselectedLabels: false,
        showSelectedLabels: true,
        items: iconsMap.keys
            .map((key) => BottomNavigationBarItem(
                label: key,
                icon: Icon(iconsMap[key]),
                backgroundColor: _colors[_position]))
            .toList(),
      );

  Widget _buildTableBarView() => TabBarView(
      controller: _tabController,
      children: tabs
          .map((e) => Center(
                  child: Text(
                e,
                style: const TextStyle(color: Colors.blue, fontSize: 20),
              )))
          .toList());
}
