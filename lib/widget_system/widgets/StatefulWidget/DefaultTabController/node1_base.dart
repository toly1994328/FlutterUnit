import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 230 DefaultTabController 默认Tab控制器  在使用TabBar和TabBarView时，需要同一个控制器实现页签和页面的控制。DefaultTabController会在未指定控制器时提供默认控制器，简化使用。
//    {
//      "widgetId": 230,
//      "name": 'DefaultTabController基本使用',
//      "priority": 1,
//      "subtitle":
//          "【length】 : 页签数量   【int】\n"
//          "【initialIndex】 : 初始页签索引   【int】\n"
//          "【child】 : 组件   【Widget】",
//    }

class DefaultTabControllerDemo extends StatelessWidget {
  final List<Tab> tabs = const [
    Tab(text: '青眼白龙'),
    Tab(text: '黑魔术师'),
    Tab(text: '混沌战士'),
  ];

  const DefaultTabControllerDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("DefaultTabController"),
            bottom: TabBar(
              tabs: tabs,
            ),
          ),
          body: TabBarView(
            children: tabs.map((Tab tab) {
              return Center(
                child: Text(
                  '${tab.text}',
                  style: const TextStyle(fontSize: 20),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
