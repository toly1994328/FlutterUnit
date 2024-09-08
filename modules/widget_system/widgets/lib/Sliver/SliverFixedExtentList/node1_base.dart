import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-31
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 186,
//      "name": 'SliverFixedExtentList基本使用',
//      "priority": 1,
//      "subtitle": "【itemExtent】 : 主轴方向强迫长度   【double】\n"
//          "【delegate】 : 孩子代理   【SliverChildDelegate】",
//    }
class SliverFixedExtentListDemo extends StatefulWidget {
  const SliverFixedExtentListDemo({Key? key}) : super(key: key);

  @override
  _SliverFixedExtentListDemoState createState() => _SliverFixedExtentListDemoState();
}

class _SliverFixedExtentListDemoState extends State<SliverFixedExtentListDemo> {
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

  Widget _buildSliverList() => SliverFixedExtentList(
        itemExtent: 50,
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
      expandedHeight: 190.0,
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
