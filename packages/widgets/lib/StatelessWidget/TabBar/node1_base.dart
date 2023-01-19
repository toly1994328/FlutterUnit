import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-16
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 58,
//      "name": 'TabBar基本使用',
//      "priority": 1,
//      "subtitle":
//          "【controller】 : 控制器   【TabController】\n"
//          "【indicatorColor】 : 指示器颜色   【指示器颜色】\n"
//          "【indicatorWeight】 : 指示器高   【double】\n"
//          "【indicatorPadding】 : 指示器边距   【EdgeInsetsGeometry】\n"
//          "【labelStyle】 : 页签文字样式   【TextStyle】\n"
//          "【unselectedLabelStyle】 : 未选中文字样式   【TextStyle】\n"
//          "【isScrollable】 : 是否可滑动   【bool】\n"
//          "【onTap】 : 页签点击回调   【Function(int)】\n"
//          "【tabs】 : 标签组件   【List<Widget>】",
//    }
class CustomTabBar extends StatefulWidget {
  const CustomTabBar({Key? key}) : super(key: key);

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
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
    return TabBar(
      onTap: (tab) => print(tab),
      labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(fontSize: 16),
      isScrollable: true,
      controller: _tabController,
      labelColor: Colors.blue,
      indicatorWeight: 3,
      indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.orangeAccent,
      tabs: tabs.map((e) => Tab(text: e)).toList(),
    );
  }
}