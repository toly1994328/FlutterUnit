import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-31
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 192,
//      "name": 'SliverOpacity基本使用',
//      "priority": 1,
//      "subtitle":
//          "【opacity】 : 透明度   【double】\n"
//          "【sliver】 : 子组件  【Function()】",
//    }
class SliverOpacityDemo extends StatelessWidget {
  final data = List.generate(128, (i) => Color(0xFF6600FF - 2 * i));

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: CustomScrollView(
        slivers: <Widget>[
          _buildSliverAppBar(),
          SliverPadding(
              padding: EdgeInsets.only(top: 10),
              sliver: SliverOpacity(opacity: 0.2, sliver: _buildSliverGrid()))
        ],
      ),
    );
  }

  Widget _buildSliverGrid() => SliverGrid.extent(
        childAspectRatio: 1 / 0.618,
        maxCrossAxisExtent: 180,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children: data
            .map((e) => Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 60,
                  color: e,
                  child: Text(
                    colorString(e),
                    style: TextStyle(color: Colors.white, shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(.5, .5),
                          blurRadius: 2)
                    ]),
                  ),
                ))
            .toList(),
      );

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 190.0,
      leading: _buildLeading(),
      title: Text('张风捷特烈'),
      actions: _buildActions(),
      elevation: 5,
      pinned: true,
      backgroundColor: Colors.orange,
      flexibleSpace: FlexibleSpaceBar(
        //伸展处布局
        titlePadding: EdgeInsets.only(left: 55, bottom: 15), //标题边距
        collapseMode: CollapseMode.parallax, //视差效果
        background: Image.asset(
          "assets/images/caver.jpeg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildLeading() => Container(
      margin: EdgeInsets.all(10),
      child: Image.asset('assets/images/icon_head.png'));

  List<Widget> _buildActions() => <Widget>[
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.star_border,
            color: Colors.white,
          ),
        )
      ];

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}
