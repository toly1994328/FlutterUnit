import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// create by 张风捷特烈 on 2020/8/2
/// contact me by email 1981462002@qq.com
/// 说明: 340 Viewport 视口组件 通常用于为滑动视图提供视口,仅构建显示和预加载的部位。可指定预加载的长度、滑动轴向等。是ScrollView的核心实现组件之一，一般不直接使用。

//    {
//      "widgetId": 340,
//      "name": "Viewport的基本使用",
//      "priority": 1,
//      "subtitle": "【offset】 : *视口偏移量   【ViewportOffset】\n"
//          "【cacheExtentStyle】: 预加载类型   【CacheExtentStyle】\n"
//          "【cacheExtent】: 预加载量   【double】\n"
//          "【axisDirection】: 滑动方向   【AxisDirection】\n"
//          "【slivers】: 子Sliver组件集   【List<Widget>】\n"
//          "【anchor】: 锚点    【double】\n"
//          "可以运行这些代码，查看ColorItem的构建情况，128个色条并非一次性全部构建。",
//    }

class ViewportDemo extends StatelessWidget {
  ViewportDemo({Key? key}) : super(key: key);

  final data = List.generate(128, (i) => Color(0xFF6600FF - 2 * i));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Scrollable(
        axisDirection: AxisDirection.down,
        physics: const BouncingScrollPhysics(),
        dragStartBehavior: DragStartBehavior.start,
        viewportBuilder: (ctx, position) => Viewport(
          axisDirection: AxisDirection.down,
          cacheExtent: 200,
          anchor: 0,
          cacheExtentStyle: CacheExtentStyle.pixel,
          offset: position,
          slivers: <Widget>[_buildSliverList()],
        ),
      ),
    );
  }

  Widget _buildSliverList() => SliverList(
    delegate: SliverChildBuilderDelegate(
            (_, int index) =>ColorItem(color: data[index],),
        childCount: data.length),
  );

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}

class ColorItem extends StatefulWidget {
  final Color color;

  const ColorItem({Key? key, required this.color}) : super(key: key);

  @override
  _ColorItemState createState() => _ColorItemState();
}

class _ColorItemState extends State<ColorItem> {

  @override
  void initState() {
    super.initState();
    print('-----initState----${colorString(widget.color)}-----------');
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.only(top: 1),
      alignment: Alignment.center,
      width: 100,
      height: 60,
      color: widget.color,
      child: Text(
        colorString(widget.color),
        style: const TextStyle(color: Colors.white, shadows: [
          Shadow(color: Colors.black, offset: Offset(.5, .5), blurRadius: 2)
        ]),
      ),
    );
  }
  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}
