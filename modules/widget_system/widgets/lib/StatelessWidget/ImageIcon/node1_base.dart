import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/27
/// contact me by email 1981462002@qq.com


class CustomImageIcon extends StatelessWidget {
  const CustomImageIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<Color, double> data = {
      Colors.blue: 50.0,
      Colors.red: 60.0,
      Colors.green: 70.0,
      Colors.yellow: 80.0,
    };
    return Wrap(
      spacing: 10,
      children: data.keys
          .map((e) => ImageIcon(
        const AssetImage("assets/images/leaf.webp"),
                color: e,
                size: data[e],
              ))
          .toList(),
    );
  }
}
