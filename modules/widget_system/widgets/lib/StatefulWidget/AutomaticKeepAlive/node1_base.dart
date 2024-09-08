import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 239 AutomaticKeepAlive 自动保活 在懒加载的列表中，允许子树请求保持状态，单独使用无效果，需要配合 KeepAliveNotification 使用。
/// link 59,162,163,165,185,188
///
//    {
//      "widgetId": 239,
//      "name": 'AutomaticKeepAlive 介绍',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 子组件   【Widget】\n"
//          "在 ListView、SliverList、GridView、SliverGrid、PageView、TabBarView 等列表、切页组件源码中都有使用到 AutomaticKeepAlive 组件。在保活某个 State 时，可以使用 AutomaticKeepAliveClientMixin 进行操作，它是对 KeepAliveNotification 使用的一个简易封装。该示例展示出 ListView 条目的状态保活。",
//    }

class AutomaticKeepAliveDemo extends StatelessWidget {
  AutomaticKeepAliveDemo({Key? key}) : super(key: key);

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
    Colors.red[50]!,
    Colors.red[100]!,
    Colors.red[200]!,
    Colors.red[300]!,
    Colors.red[400]!,
    Colors.red[500]!,
    Colors.red[600]!,
    Colors.red[700]!,
    Colors.red[800]!,
    Colors.red[900]!,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (_, index) => ColorBox(
          color: data[index],
          index: index,
        ),
      ),
    );
  }
}

class ColorBox extends StatefulWidget {
  final Color color;
  final int index;

  const ColorBox({Key? key, required this.color, required this.index})
      : super(key: key);

  @override
  _ColorBoxState createState() => _ColorBoxState();
}

class _ColorBoxState extends State<ColorBox> with AutomaticKeepAliveClientMixin {
  bool _checked = false;

  @override
  void initState() {
    super.initState();
    _checked = false;
    print('-----_ColorBoxState#initState---${widget.index}-------');
  }

  @override
  void dispose() {
    print('-----_ColorBoxState#dispose---${widget.index}-------');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      alignment: Alignment.center,
      height: 50,
      color: widget.color,
      child: Row(
        children: [
          const SizedBox(
            width: 60,
          ),
          Checkbox(
            value: _checked,
            onChanged: (bool? v) {
              setState(() {
                _checked = v ?? false;
              });
            },
          ),
          Text(
            "index ${widget.index}: ${colorString(widget.color)}",
            style: const TextStyle(color: Colors.white, shadows: [
              Shadow(
                color: Colors.black,
                offset: Offset(.5, .5),
                blurRadius: 2,
              )
            ]),
          ),
        ],
      ),
    );
  }

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";

  @override
  bool get wantKeepAlive => true;
}
