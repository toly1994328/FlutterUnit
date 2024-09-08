import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-30
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 183,
//      "name": 'CustomScrollView基本使用',
//      "priority": 1,
//      "subtitle": "【slivers】 : 子组件列表   【List<Widget>】\n"
//          "【reverse】 : 是否反向   【bool】\n"
//          "【scrollDirection】 : 滑动方向   【Axis】\n"
//          "【controller】 : 控制器   【ScrollController】",
//    }
class CustomScrollViewDemo extends StatelessWidget {
  CustomScrollViewDemo({Key? key}) : super(key: key);

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
        anchor: 0,
        scrollDirection: Axis.vertical,
        reverse: false,
        slivers: <Widget>[_buildSliverAppBar(), _buildSliverFixedExtentList()],
      ),
    );
  }

  TextStyle get textStyle => const TextStyle(color: Colors.white, shadows: [
        Shadow(
          color: Colors.black,
          offset: Offset(.5, .5),
          blurRadius: 2,
        )
      ]);

  Widget _buildSliverFixedExtentList() => SliverFixedExtentList(
        itemExtent: 60,
        delegate: SliverChildBuilderDelegate(
            (_, int index) => Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 50,
                  color: data[index],
                  child: Text(
                    colorString(data[index]),
                    style: textStyle,
                  ),
                ),
            childCount: data.length),
      );

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";

  _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 190.0,
      leading: Container(
          margin: const EdgeInsets.all(10),
          child: Image.asset('assets/images/icon_head.webp')),
      flexibleSpace: FlexibleSpaceBar(
        //伸展处布局
        titlePadding: const EdgeInsets.only(left: 55, bottom: 15), //标题边距
        collapseMode: CollapseMode.parallax, //视差效果
        title: const Text(
          '张风捷特烈',
          style: TextStyle(color: Colors.black, //标题
              shadows: [
                Shadow(
                  color: Colors.blue,
                  offset: Offset(1, 1),
                  blurRadius: 2,
                )
              ]),
        ),
        background: Image.asset(
          "assets/images/caver.webp",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
