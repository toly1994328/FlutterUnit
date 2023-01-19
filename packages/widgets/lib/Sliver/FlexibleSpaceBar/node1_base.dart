import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-31
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 196,
//      "name": 'FlexibleSpaceBar基本使用',
//      "priority": 1,
//      "subtitle": "【title】 : 标题组件   【Widget】\n"
//          "【titlePadding】 : 标题间距   【EdgeInsetsGeometry】\n"
//          "【collapseMode】 : 折叠模式   【CollapseMode】\n"
//          "【stretchModes】 : 延伸模式   【List<StretchMode>】\n"
//          "【background】 : 背景组件   【Widget】\n"
//          "【centerTitle】 : 是否居中   【bool】",
//    }

class FlexibleSpaceBarDemo extends StatelessWidget {
  FlexibleSpaceBarDemo({Key? key}) : super(key: key);

  final List<Color> data =[
    Colors.blue[50]!,
    Colors.blue[100]!,
    Colors.blue[200]!,
    Colors.blue[300]!,
    Colors.blue[400]!,
    Colors.blue[500]!,
    Colors.blue[600]!,
    Colors.blue[700]!,
    Colors.blue[800]!,
    Colors.blue[900]!,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: CustomScrollView(
        slivers: <Widget>[_buildSliverAppBar(), _buildSliverFixedExtentList()],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 190.0,
      leading: _buildLeading(),
      actions: _buildActions(),
      pinned: true,
      backgroundColor: Colors.blue,
      flexibleSpace: FlexibleSpaceBar(//伸展处布局
        centerTitle: false,
        title: const Text(
          '张风捷特烈',
          style: TextStyle(shadows: [
            Shadow(color: Colors.blue, offset: Offset(1, 1), blurRadius: 2)
          ]),
        ),
        titlePadding: const EdgeInsets.only(left: 55, bottom: 15),
        //标题边距
        collapseMode: CollapseMode.parallax,
        //视差效果
        stretchModes: const [StretchMode.blurBackground, StretchMode.zoomBackground],
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

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}
