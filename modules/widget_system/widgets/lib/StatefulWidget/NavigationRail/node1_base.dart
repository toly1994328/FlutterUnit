import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2022/7/23
/// contact me by email 1981462002@qq.com


class CustomNavigationRail extends StatefulWidget {
  const CustomNavigationRail({Key? key}) : super(key: key);

  @override
  State<CustomNavigationRail> createState() => _CustomNavigationRailState();
}

class _CustomNavigationRailState extends State<CustomNavigationRail> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _NavigationRailDemo(
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

class _NavigationRailDemo extends StatefulWidget {
  final ValueChanged<int>? onDestinationSelected;

  const _NavigationRailDemo({Key? key, this.onDestinationSelected})
      : super(key: key);

  @override
  State<_NavigationRailDemo> createState() => _NavigationRailDemoState();
}

class _NavigationRailDemoState extends State<_NavigationRailDemo> {
  int _selectIndex = 0;

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

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      onDestinationSelected: _onDestinationSelected,
      labelType: NavigationRailLabelType.all,
      destinations: destinations,
      selectedIndex: _selectIndex,
    );
  }

  void _onDestinationSelected(int value) {
    _selectIndex = value;
    setState(() {});
    widget.onDestinationSelected?.call(value);
  }
}
