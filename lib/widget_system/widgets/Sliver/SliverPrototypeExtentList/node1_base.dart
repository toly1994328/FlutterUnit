import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 314 SliverPrototypeExtentList Sliver原型延伸列表 其中prototypeItem属性是一个Widget,该Widget负责在主轴方向上约束item尺寸，但会不显示出来。delegate接受一个SliverChildDelegate完成item的创建。
//    {
//      "widgetId": 314,
//      "name": 'SliverPrototypeExtentList基本使用',
//      "priority": 1,
//      "subtitle":
//          "【prototypeItem】 : 主轴方向尺寸组件   【Widget】\n"
//          "【delegate】 : 孩子代理   【SliverChildDelegate】",
//    }
class SliverPrototypeExtentListDemo extends StatefulWidget {
  const SliverPrototypeExtentListDemo({Key? key}) : super(key: key);

  @override
  _SliverPrototypeExtentListDemoState createState() =>
      _SliverPrototypeExtentListDemoState();
}

class _SliverPrototypeExtentListDemoState
    extends State<SliverPrototypeExtentListDemo> {
  final List<Color> data = [
    Colors.orange[50]!,
    Colors.orange[100]!,
    Colors.orange[200]!,
    Colors.orange[300]!,
    Colors.orange[400]!,
    Colors.orange[500]!,
    Colors.orange[600]!,
    Colors.orange[700]!,
    Colors.orange[800]!,
    Colors.orange[900]!,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: CustomScrollView(
        slivers: <Widget>[_buildSliverAppBar(), _buildSliverList()],
      ),
    );
  }

  Widget _buildSliverList() => SliverPrototypeExtentList(
        prototypeItem: Container(
          height: 80,
        ),
        delegate: SliverChildBuilderDelegate(
            (_, int index) => Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 60,
                  color: data[index],
                  child: Text(
                    colorString(data[index]),
                    style: const TextStyle(color: Colors.white, shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(.5, .5),
                          blurRadius: 2)
                    ]),
                  ),
                ),
            childCount: data.length),
      );

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 150.0,
      leading: _buildLeading(),
      title: const Text('张风捷特烈'),
      actions: _buildActions(),
      elevation: 5,
      pinned: true,
      backgroundColor: Colors.orange,
      flexibleSpace: FlexibleSpaceBar(
        //伸展处布局
        titlePadding: const EdgeInsets.only(left: 55, bottom: 15), //标题边距
        collapseMode: CollapseMode.parallax, //视差效果
        background: Image.asset(
          "assets/images/caver.webp",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildLeading() => Container(
      margin: const EdgeInsets.all(10),
      child: Image.asset('assets/images/icon_head.webp'));

  List<Widget> _buildActions() => <Widget>[
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.star_border,
            color: Colors.white,
          ),
        )
      ];

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}
