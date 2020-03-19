import 'package:flutter/material.dart';
import 'package:flutter_unit/app/res/cons.dart';

//    {
//      "widgetId": 60,
//      "name": 'BottomNavigationBar基本使用',
//      "priority": 1,
//      "subtitle":
//          "【currentIndex】 : 当前索引   【int】\n"
//          "【elevation】 : 影深   【double】\n"
//          "【type】 : 类型*2   【BottomNavigationBarType】\n"
//          "【fixedColor】 : type为fix的颜色   【Color】\n"
//          "【backgroundColor】 : 背景色   【Color】\n"
//          "【iconSize】 : 图标大小   【double】\n"
//          "【selectedLabelStyle】 : 选中文字样式   【TextStyle】\n"
//          "【unselectedLabelStyle】 : 未选中文字样式   【TextStyle】\n"
//          "【showUnselectedLabels】 : 显示未选中标签   【bool】\n"
//          "【showSelectedLabels】 : 显示选中标签   【bool】\n"
//          "【items】 : 条目   【List<BottomNavigationBarItem>】\n"
//          "【onTap】 : 点击事件   【Function(int)】",
//    }
class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  var _position = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.shifting;
  final iconsMap = {
    //底栏图标
    "图鉴": Icons.home, "动态": Icons.toys,
    "喜欢": Icons.favorite, "手册": Icons.class_,
    "我的": Icons.account_circle,
  };
  final _colors = [
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.green,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        _buildOp(),
        _buildBottomNavigationBar(),
      ],
    );
  }

  bool get isShifting => _type == BottomNavigationBarType.shifting;

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      onTap: (position) => setState(() => _position = position),
      currentIndex: _position,
      elevation: 1,
      type: _type,
      fixedColor: isShifting ? Colors.white : _colors[_position],
      backgroundColor: Colors.white,
      iconSize: 25,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      showUnselectedLabels: false,
      showSelectedLabels: true,
      items: iconsMap.keys
          .map((key) => BottomNavigationBarItem(
              title: Text(
                key,
              ),
              icon: Icon(iconsMap[key]),
              backgroundColor: _colors[_position]))
          .toList(),
    );
  }

  Widget _buildOp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          _type.toString(),
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        Switch(
            value: _type == BottomNavigationBarType.shifting,
            onChanged: (b) {
              setState(() => _type = b
                  ? BottomNavigationBarType.shifting
                  : BottomNavigationBarType.fixed);
            }),
      ],
    );
  }
}

//    {
//      "widgetId": 60,
//      "name": '可结合PageView进行切页',
//      "priority": 2,
//      "subtitle":
//          "在onTap时进行使用控制器进行切页",
//    }
class BottomNavigationBarWithPageView extends StatefulWidget {
  @override
  _BottomNavigationBarWithPageViewState createState() =>
      _BottomNavigationBarWithPageViewState();
}

class _BottomNavigationBarWithPageViewState
    extends State<BottomNavigationBarWithPageView> {
  var _position = 0;
  final iconsMap = {
    //底栏图标
    "图鉴": Icons.home, "动态": Icons.toys,
    "喜欢": Icons.favorite, "手册": Icons.class_,
    "我的": Icons.account_circle,
  };
  final _colors = [
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.green,
    Colors.purple,
  ];
  PageController _controller; //页面控制器，初始0

  @override
  void initState() {
    _controller = PageController(
      initialPage: _position,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.orange.withAlpha(88),
            width: MediaQuery.of(context).size.width,
            height: 150,
            child: PageView(
              controller: _controller,
              children: iconsMap.keys
                  .map((e) => Center(
                        child: Text(
                          e,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ))
                  .toList(),
            ),
          ),
          _buildBottomNavigationBar()
        ],
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      onTap: (position) {
        _controller.jumpToPage(position);
        setState(() => _position = position);
      },
      currentIndex: _position,
      elevation: 1,
      type: BottomNavigationBarType.shifting,
      fixedColor: Colors.white,
      backgroundColor: Colors.white,
      iconSize: 25,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      showUnselectedLabels: false,
      showSelectedLabels: true,
      items: iconsMap.keys
          .map((key) => BottomNavigationBarItem(
              title: Text(
                key,
              ),
              icon: Icon(Cons.ICONS_MAP[key]),
              backgroundColor: _colors[_position]))
          .toList(),
    );
  }
}
