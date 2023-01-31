import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 304 SliverLayoutBuilder Sliver布局构造器 Sliver家族一员，在滑动过程中可以通过回调出的 SliverConstraints 对象进行子组件的构造。
//    {
//      "widgetId": 304,
//      "name": 'SliverLayoutBuilder基本使用',
//      "priority": 1,
//      "subtitle": "【builder】 : 组件构造器   【SliverLayoutWidgetBuilder】",
//    }
class SliverLayoutBuilderDemo extends StatefulWidget {
  const SliverLayoutBuilderDemo({Key? key}) : super(key: key);

  @override
  _SliverLayoutBuilderDemoState createState() =>
      _SliverLayoutBuilderDemoState();
}

class _SliverLayoutBuilderDemoState extends State<SliverLayoutBuilderDemo> {
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
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          _buildSliverAppBar(),
          SliverLayoutBuilder(
            builder: _buildSliver,
          ),
          _buildSliverList(),
        ],
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
      expandedHeight: 120.0,
      leading: Container(
          margin: const EdgeInsets.all(10),
          child: Image.asset('assets/images/icon_head.webp')),
      title: const Text('张风捷特烈'),
      actions: _buildActions(),
      elevation: 5,
      pinned: true,
      backgroundColor: Colors.orange,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 55, bottom: 15), //标题边距
        collapseMode: CollapseMode.parallax, //视差效果
        background: Image.asset(
          "assets/images/caver.webp",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

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

  Widget _buildSliver(BuildContext context, SliverConstraints constraints) {
    return SliverToBoxAdapter(
      child: Container(
        alignment: Alignment.center,
        height: constraints.remainingPaintExtent / 3,
        color: Colors.red,
        child: const Text(
          "SliverLayoutBuilder",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
