
import 'package:flutter/material.dart';



//       minWidth: 72,
//       minExtendedWidth: 200 ,
//       unselectedIconTheme: const IconThemeData(color: textColor) ,
//       selectedIconTheme: const IconThemeData(color: activeColor) ,
//       unselectedLabelTextStyle: labelStyle,
//       selectedLabelTextStyle: labelStyle,

/// create by 张风捷特烈 on 2022/7/23
/// contact me by email 1981462002@qq.com
/// 说明: 358 NavigationRail 侧导航栏，一般用于桌面导航菜单。支持展开和收缩区域，可指定首尾位置组件。。
//    {
//      "widgetId": 358,
//      "name": "NavigationRail 样式",
//      "priority": 3,
//      "subtitle": "【useIndicator】 : 是否显示指示器   【bool】\n"
//          "【indicatorColor】: 指示器颜色    【Color?】\n"
//          "【backgroundColor】: 背景色    【Color?】\n"
//          "【labelType】: 标签样式    【NavigationRailLabelType?】\n"
//          "【selectedIconTheme】: 选中图标样式    【IconThemeData?】\n"
//          "【unselectedIconTheme】: 未选中图标样式    【IconThemeData?】\n"
//          "【selectedLabelTextStyle】: 选中文字样式    【TextStyle?】\n"
//          "【unselectedLabelTextStyle】: 未选中文字样式    【TextStyle?】\n"
//          "【minExtendedWidth】: 展开宽度    【double?】\n"
//          "【minWidth】: 未展开宽度    【double?】",
//    }


class DarkNavigationRail extends StatefulWidget {
  const DarkNavigationRail({Key? key}) : super(key: key);

  @override
  State<DarkNavigationRail> createState() => _DarkNavigationRailState();
}

class _DarkNavigationRailState extends State<DarkNavigationRail> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Row(
            children: [
              DarkExtendableNavigation(
                onDestinationSelected: _onDestinationSelected,
              ),
              Expanded(
                  child: PageView(
                    controller: _controller,
                    children: const [
                      _TestContent(content: '消息'),
                      _TestContent(content: '视频会议'),
                      _TestContent(content: '通讯录'),
                      _TestContent(content: '云文档'),
                      _TestContent(content: '工作台'),
                      _TestContent(content: '日历'),
                    ],
                  ))
            ],
    );
  }

  void _onDestinationSelected(int value) {
    _controller.jumpToPage(value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _TestContent extends StatelessWidget {
  final String content;

  const _TestContent({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
          content,
          style: const TextStyle(fontSize: 26),
        ));
  }
}

class DarkExtendableNavigation extends StatefulWidget {
  final ValueChanged<int>? onDestinationSelected;

  const DarkExtendableNavigation({Key? key, this.onDestinationSelected})
      : super(key: key);

  @override
  State<DarkExtendableNavigation> createState() => _DarkExtendableNavigationState();
}

class _DarkExtendableNavigationState extends State<DarkExtendableNavigation> {
  int _selectIndex = 0;
  bool _extended = false;

  final List<NavigationRailDestination> destinations = const [
    NavigationRailDestination(
        icon: Icon(Icons.message_outlined), label: Text("消息")),
    NavigationRailDestination(
        icon: Icon(Icons.video_camera_back_outlined), label: Text("视频会议")),
    NavigationRailDestination(
        icon: Icon(Icons.book_outlined), label: Text("通讯录")),
    NavigationRailDestination(
        icon: Icon(Icons.cloud_upload_outlined), label: Text("云文档")),
    NavigationRailDestination(
        icon: Icon(Icons.games_sharp), label: Text("工作台")),
    NavigationRailDestination(
        icon: Icon(Icons.calendar_month), label: Text("日历"))
  ];

  Widget buildLeading() {
    return GestureDetector(
        onTap: _toggleExtended,
        child: const Icon(
          Icons.menu_open,
          color: Colors.grey,
        ));
  }

  @override
  Widget build(BuildContext context) {
    const Color textColor =  Color(0xffcfd1d7);
    const  Color activeColor =  Colors.white;
    const TextStyle labelStyle =  TextStyle(color: textColor,fontSize: 11);

    return NavigationRail(
      leading: buildLeading(),
      extended: _extended,
      labelType: NavigationRailLabelType.none,
      useIndicator: true,
      indicatorColor: Colors.blue,
      elevation: 1,
      backgroundColor: const Color(0xff324465),
      minWidth: 72,
      minExtendedWidth: 200 ,
      unselectedIconTheme: const IconThemeData(color: textColor) ,
      selectedIconTheme: const IconThemeData(color: activeColor) ,
      unselectedLabelTextStyle: labelStyle,
      selectedLabelTextStyle: labelStyle,
      trailing: const Expanded(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: FlutterLogo(),
          ),
        ),
      ),
      onDestinationSelected: _onDestinationSelected,
      destinations: destinations,
      selectedIndex: _selectIndex,
    );
  }

  void _onDestinationSelected(int value) {
    _selectIndex = value;
    setState(() {});
    widget.onDestinationSelected?.call(value);
  }

  void _toggleExtended() {
    setState(() {
      _extended = !_extended;
    });
  }
}
