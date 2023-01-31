import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 59,
//      "name": 'TabBarView需要与TabBar联用',
//      "priority": 1,
//      "subtitle": "【controller】 : 控制器   【TabController】\n"
//          "【children】 : 孩子们   【指示器颜色】\n"
//          "【physics】 : 表现   【ScrollPhysics】",
//    }
class CustomTabBarView extends StatefulWidget {
  const CustomTabBarView({Key? key}) : super(key: key);

  @override
  _CustomTabBarViewState createState() => _CustomTabBarViewState();
}

class _CustomTabBarViewState extends State<CustomTabBarView> with SingleTickerProviderStateMixin {
  final List<String> tabs = const [
    '风画庭',
    '雨韵舍',
    '雷鸣殿',
    '电疾堂',
    '霜寒阁',
    '雪月楼',
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
    return Column(
      children: <Widget>[
        _buildTabBar(),
        Container(
            color: Colors.purple,
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: _buildTableBarView())
      ],
    );
  }

  Widget _buildTabBar() => TabBar(
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

  Widget _buildTableBarView() => TabBarView(
      controller: _tabController,
      children: tabs.map((e) => Center(
                  child: Text(
                e,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ))).toList());
}
