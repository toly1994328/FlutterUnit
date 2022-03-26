import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-27
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 163,
//      "name": 'GridView.extent构造',
//      "priority": 3,
//      "subtitle":
//          "【maxCrossAxisExtent】 : box轴向长度   【double】\n"
//          "【reverse】 : 是否反向滑动   【bool】\n"
//          "【shrinkWrap】 : 无边界时是否包裹  【bool】",
//    }
class ExtentGridView extends StatelessWidget {
  ExtentGridView({Key? key}) : super(key: key);

  final List<Color> data = List.generate(128, (i) => Color(0xFF00FFFF - 2 * i));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GridView.extent(
        scrollDirection: Axis.horizontal,
        maxCrossAxisExtent: 80.0,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 0.618,
        children: data.map((color) => _buildItem(color)).toList(),
      ),
    );
  }

  Container _buildItem(Color color) => Container(
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