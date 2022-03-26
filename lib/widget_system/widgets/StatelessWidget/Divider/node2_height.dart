
/// create by 张风捷特烈 on 2020-03-24
/// contact me by email 1981462002@qq.com
/// 说明:
///
import 'package:flutter/material.dart';


class HeightDivider extends StatelessWidget {
  const HeightDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<double> dataThickness = [10.0, 20.0, 30.0, 40.0];
    List<Color> dataColor = [
      Colors.red, Colors.yellow,
      Colors.blue, Colors.green];
    Map<Color,double> data = Map.fromIterables(dataColor, dataThickness);

    return Column(
      children: dataColor
          .map((Color color) => Divider(
        color: color,
        indent:data[color],
        endIndent: data[color]!*2,
        height: data[color],
        thickness: data[color]!/10,
      ))
          .toList(),
    );
  }
}
