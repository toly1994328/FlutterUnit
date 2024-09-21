import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com


class TabPageSelectorDemo extends StatefulWidget {
  const TabPageSelectorDemo({Key? key}) : super(key: key);

  @override
  _TabPageSelectorDemoState createState() => _TabPageSelectorDemoState();
}

class _TabPageSelectorDemoState extends State<TabPageSelectorDemo>
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
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(color: Colors.purple, child: _buildTableBarView()),
          Positioned(
            bottom: 10,
            child: buildTabPageSelector(),
          ),
        ],
      ),
    );
  }

  Widget buildTabPageSelector() => TabPageSelector(
            controller: _tabController,
            color: Colors.white,
            indicatorSize: 10,
            selectedColor: Colors.orangeAccent,
          );

  Widget _buildTableBarView() => TabBarView(
      controller: _tabController,
      children: tabs
          .map((e) => Center(
                  child: Text(
                e,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              )))
          .toList());
}
