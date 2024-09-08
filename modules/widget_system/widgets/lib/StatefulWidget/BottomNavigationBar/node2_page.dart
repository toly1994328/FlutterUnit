import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-23
/// contact me by email 1981462002@qq.com
/// 详情:
//    {
//      "widgetId": 60,
//      "name": '可结合PageView进行切页',
//      "priority": 2,
//      "subtitle":
//          "在onTap时进行使用控制器进行切页",
//    }
class BottomNavigationBarWithPageView extends StatefulWidget {
  const BottomNavigationBarWithPageView({Key? key}) : super(key: key);

  @override
  _BottomNavigationBarWithPageViewState createState() =>
      _BottomNavigationBarWithPageViewState();
}

class _BottomNavigationBarWithPageViewState
    extends State<BottomNavigationBarWithPageView> {
  int _position = 0;
  final Map<String, IconData> iconsMap = {
    //底栏图标
    "图鉴": Icons.home, "动态": Icons.toys,
    "喜欢": Icons.favorite, "手册": Icons.class_,
    "我的": Icons.account_circle,
  };
  final List<Color> _colors = [
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.green,
    Colors.purple,
  ];
  late PageController _controller; //页面控制器，初始0

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
    return Column(
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
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
        _buildBottomNavigationBar()
      ],
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
  }
}
