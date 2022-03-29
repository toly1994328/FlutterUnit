import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-27
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 163,
//      "name": 'GridView.builder构造',
//      "priority": 4,
//      "subtitle":
//          "【itemCount】 : 条目数量   【int】\n"
//          "【gridDelegate】 : 网格代理   【SliverGridDelegate】\n"
//          "【itemBuilder】 : 条目构造器  【IndexedWidgetBuilder】",
//    }
class BuilderGridView extends StatelessWidget {
  BuilderGridView({Key? key}) : super(key: key);

  final List<Color> data = List.generate(128, (i) => Color(0xFF33FFF - 2 * i));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GridView.builder(
          itemCount: data.length,
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //网格代理：定交叉轴数目
              crossAxisCount: 4, //条目个数
              mainAxisSpacing: 5, //主轴间距
              crossAxisSpacing: 5, //交叉轴间距
              childAspectRatio: 1 / 0.618),
          itemBuilder: (_, int position) => _buildItem(data[position])),
    );
  }

  Widget _buildItem(Color color) => Container(
        alignment: Alignment.center,
        width: 100,
        height: 30,
        color: color,
        child: Text(
          colorString(color),
          style: const TextStyle(
            color: Colors.white,
            shadows: [
              Shadow(color: Colors.black, offset: Offset(.5, .5), blurRadius: 2)
            ],
          ),
        ),
      );

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}