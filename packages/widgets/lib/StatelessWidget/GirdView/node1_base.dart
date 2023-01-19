
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-27
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 163,
//      "name": 'GridView.count构造',
//      "priority": 1,
//      "subtitle":
//          "【children】 : 子组件列表   【List<Widget>】\n"
//          "【crossAxisCount】 : 主轴一行box数量  【int】\n"
//          "【mainAxisSpacing】 : 主轴每行间距  【double】\n"
//          "【crossAxisSpacing】 : 交叉轴每行间距  【double】\n"
//          "【childAspectRatio】 : box主长/交叉轴长  【double】\n"
//          "【crossAxisCount】 : 主轴一行数量  【int】",
//    }
class CustomGridView extends StatelessWidget {
  CustomGridView({Key? key}) : super(key: key);

  final List<Color> data = List.generate(128, (i) => Color(0xFFFF00FF - 2 * i));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 1 / 0.618,
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