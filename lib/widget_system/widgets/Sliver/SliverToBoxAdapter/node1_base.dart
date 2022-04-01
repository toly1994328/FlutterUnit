import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-31
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 189,
//      "name": 'SliverToBoxAdapter基本使用',
//      "priority": 1,
//      "subtitle": "【child】 : 子组件   【Widget】",
//    }
class SliverToBoxAdapterDemo extends StatelessWidget {
  SliverToBoxAdapterDemo({Key? key}) : super(key: key);

  final List<Color> data = [
    Colors.purple[50]!,
    Colors.purple[100]!,
    Colors.purple[200]!,
    Colors.purple[300]!,
    Colors.purple[400]!,
    Colors.purple[500]!,
    Colors.purple[600]!,
    Colors.purple[700]!,
    Colors.purple[800]!,
    Colors.purple[900]!,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: CustomScrollView(
        slivers: <Widget>[
          _buildSliverAppBar(),
          _buildCommonWidget(),
          _buildSliverList()
        ],
      ),
    );
  }

  Widget _buildCommonWidget() => SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          color: Colors.grey.withAlpha(22),
          child: ListTile(
            leading: Image.asset("assets/images/icon_head.webp"),
            title: const Text("以梦为马"),
            subtitle: const Text("海子"),
            selected: true,
            contentPadding: const EdgeInsets.all(5),
            trailing: const Icon(Icons.more_vert),
          ),
        ),
      );

  Widget _buildSliverList() => SliverList(
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
      elevation: 2,
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
