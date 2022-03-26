/// create by 张风捷特烈 on 2020/4/25
/// contact me by email 1981462002@qq.com
/// 说明:
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  CustomBackButton({Key? key}) : super(key: key);

  final List<Color> data = [
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.green
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 10,
        children: data
            .map((e) => BackButton(
                  color: e,
                ))
            .toList());
  }
}
