import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com


class ColoredBoxDemo extends StatelessWidget {
  const ColoredBoxDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.red,
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.blue
        ),
          alignment: Alignment.center,
          width: 250,
          height: 100,
          child: const Text(
            "蓝色是加了 margin 和圆角的 Container，外层包裹红色的 ColoredBox，注意作用范围。",
            style: TextStyle(color: Colors.white),
          ),
      ),
    );
  }
}
