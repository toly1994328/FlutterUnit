import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/25
/// contact me by email 1981462002@qq.com

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  List<Color> get data => [
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
