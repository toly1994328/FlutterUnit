import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 158,
//      "name": 'CupertinoTabScaffold基本用法',
//      "priority": 1,
//      "subtitle":
//          "【tabBar】 : 页签条   【CupertinoTabBar】\n"
//          "【backgroundColor】 : 背景色   【Color】\n"
//          "【controller】 : 控制器   【CupertinoTabController】\n"
//          "【tabBuilder】 : 页面构造器   【IndexedWidgetBuilder】",
//    }
class CustomCupertinoTabScaffold extends StatefulWidget {
  const CustomCupertinoTabScaffold({Key? key}) : super(key: key);

  @override
  _CustomCupertinoTabScaffoldState createState() =>
      _CustomCupertinoTabScaffoldState();
}

class _CustomCupertinoTabScaffoldState
    extends State<CustomCupertinoTabScaffold> {
  int _position = 0;
  final Map<String,IconData> iconsMap = {
    //底栏图标
    "图鉴": Icons.home, "动态": Icons.toys,
    "喜欢": Icons.favorite, "手册": Icons.class_,
    "我的": Icons.account_circle,
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 300,
      child: CupertinoTabScaffold(
          backgroundColor: Colors.grey.withAlpha(11),
          tabBar: _buildTabBar(),
          tabBuilder: (_, index) => _buildContent(index)),
    );
  }

  CupertinoTabBar _buildTabBar() => CupertinoTabBar(
        currentIndex: _position,
        onTap: (value) => setState(() => _position = value),
        items: iconsMap.keys
            .map((e) => BottomNavigationBarItem(
                  icon: Icon(
                    iconsMap[e],
                  ),
                  label: e,
                ))
            .toList(),
        activeColor: Colors.blue,
        inactiveColor: const Color(0xff333333),
        backgroundColor: const Color(0xfff1f1f1),
        iconSize: 25.0,
      );

  _buildContent(int index) => Container(
      alignment: Alignment.center,
      child: Text(iconsMap.keys.toList()[index]),
    );
}
