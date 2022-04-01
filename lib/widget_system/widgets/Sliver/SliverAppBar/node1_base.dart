import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-30
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 184,
//      "name": 'SliverAppBar基本使用',
//      "priority": 1,
//      "subtitle": "【leading】 : 左侧组件   【Widget】\n"
//          "【title】 : 中间组件   【Widget】\n"
//          "【actions】 : 尾部组件列表   【List<Widget>】\n"
//          "【floating】 : 是否浮动   【bool】\n"
//          "【pinned】 : 是否顶部停留   【bool】\n"
//          "【snap】 : 是否半收展   【bool】\n"
//          "【bottom】 : 底部组件   【PreferredSizeWidget】\n"
//          "【expandedHeight】 : 延展高度   【double】\n"
//          "【elevation】 : 影深   【double】\n"
//          "【flexibleSpace】 : 延展空间   【FlexibleSpaceBar】\n"
//          "【backgroundColor】 : 背景色   【Color】\n"
//          "【controller】 : 控制器   【ScrollController】\n"
//          "   snap为true时必需floating为true",
//    }
class SliverAppBarDemo extends StatefulWidget {
  const SliverAppBarDemo({Key? key}) : super(key: key);

  @override
  _SliverAppBarDemoState createState() => _SliverAppBarDemoState();
}

class _SliverAppBarDemoState extends State<SliverAppBarDemo> {
  bool _floating = false;
  bool _pinned = false;
  bool _snap = false;

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
    return Column(
      children: <Widget>[
        _buildTool(),
        SizedBox(
          height: 300,
          child: CustomScrollView(
            slivers: <Widget>[
              _buildSliverAppBar(),
              _buildSliverFixedExtentList()
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSliverAppBar() {
    print(_floating);
    return SliverAppBar(
      expandedHeight: 190.0,
      leading: _buildLeading(),
      title: const Text('张风捷特烈'),
      actions: _buildActions(),
      elevation: 5,
      floating: _floating,
      pinned: _pinned,
      snap: _snap,
      backgroundColor: Colors.orange,
      flexibleSpace: FlexibleSpaceBar(//伸展处布局
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

  Widget _buildTool() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            const Text('floating'),
            Switch(
                value: _floating,
                onChanged: (v) {
                  if(_snap&&!v){
                    _snap =false;
                  }
                  setState(() => _floating = v);
                }),
          ],
        ),
        Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            const Text('pinned'),
            Switch(
                value: _pinned,
                onChanged: (v) => setState(() => _pinned = v)),
          ],
        )       ,Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            const Text('snap'),
            Switch(
                value: _snap,
                onChanged: (v) {
                  if(_floating){
                    setState(() => _snap = v);
                  }
                }),
          ],
        )
      ],
    );
  }
}
