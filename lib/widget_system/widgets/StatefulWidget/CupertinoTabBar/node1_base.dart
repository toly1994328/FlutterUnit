import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-31
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 63,
//      "name": 'CupertinoTabBar基本用法',
//      "priority": 1,
//      "subtitle":
//          "【currentIndex】 : 当前激活索引   【Widget】\n"
//          "【items】 : 条目组件   【Widget】\n"
//          "【backgroundColor】 : 背景色   【Color】\n"
//          "【inactiveColor】 : 非激活色   【Color】\n"
//          "【activeColor】 : 激活色   【Color】\n"
//          "【iconSize】 : 图标大小    【double】\n"
//          "【border】 : 边线   【Border】\n"
//          "【onTap】 : 点击事件   【Function(int)】",
//    }
class CustomCupertinoTabBar extends StatefulWidget {
  const CustomCupertinoTabBar({Key? key}) : super(key: key);

  @override
  _CustomCupertinoTabBarState createState() => _CustomCupertinoTabBarState();
}

class _CustomCupertinoTabBarState extends State<CustomCupertinoTabBar> {
  int _position = 0;
  final Map<String,IconData> iconsMap = {
    //底栏图标
    "图鉴": Icons.home, "动态": Icons.toys,
    "喜欢": Icons.favorite, "手册": Icons.class_,
    "我的": Icons.account_circle,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildContent(context),
        _buildTabBar(),
      ],
    );
  }

  Widget _buildTabBar() {
    return CupertinoTabBar(
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
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: 150,
      color: const Color(0xffE7F3FC),
      child: Text(
        iconsMap.keys.toList()[_position],
        style: const TextStyle(color: Colors.blue, fontSize: 24),
      ),
    );
  }
}
