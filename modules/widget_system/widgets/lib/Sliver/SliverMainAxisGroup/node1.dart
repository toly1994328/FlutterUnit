import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2023/8/18
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 268,
//      "name": 'SliverMainAxisGroup 基本使用',
//      "priority": 1,
//      "subtitle":
//          "【slivers】 : 子组件列表   【List<Widget>】\n"
//          "可结合 SliverPersistentHeader 实现分组，标题吸顶效果。",
//    }
class ItemData {
  final String groupName;
  final List<String> users;

  ItemData({required this.groupName, this.users = const []});

  static List<ItemData> get testData => [
    ItemData(groupName: '幻将术士', users: ['梦小梦', '梦千']),
    ItemData(
        groupName: '幻将剑客', users: ['捷特', '龙少', '莫向阳', '何解连', '浪封', '梦飞烟']),
    ItemData(groupName: '幻将弓者', users: ['巫缨', '巫妻孋', '摄王', '裔王', '梦童']),
    ItemData(
        groupName: '其他', users: List.generate(20, (index) => '小兵$index')),
  ];
}

class SliverMainAxisGroupDemo extends StatelessWidget{
  const SliverMainAxisGroupDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: CustomScrollView(
        slivers: ItemData.testData.map(_buildGroup).toList(),
      ),
    );
  }

  Widget _buildGroup(ItemData itemData) {
    return SliverMainAxisGroup(slivers: [
      SliverPersistentHeader(
        pinned: true,
        delegate: _HeaderDelegate(itemData.groupName),
      ),
      SliverList(
        // tag2
        delegate: SliverChildBuilderDelegate(
              (_, index) => _buildItemByUser(itemData.users[index]),
          childCount: itemData.users.length,
        ),
      ),
    ]);
  }

  Widget _buildItemByUser(String user) {
    return Container(
      alignment: Alignment.center,
      height: 56,
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 10.0),
            child: FlutterLogo(size: 30),
          ),
          Text(
            user,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  const _HeaderDelegate(this.title);

  final String title;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        alignment: Alignment.centerLeft,
        color: const Color(0xffF6F6F6),
        padding: const EdgeInsets.only(left: 20),
        height: 40,
        child: Text(title));
  }

  @override
  double get maxExtent => minExtent;

  @override
  double get minExtent => 40;

  @override
  bool shouldRebuild(covariant _HeaderDelegate oldDelegate) => title!=oldDelegate.title;
}