

/// create by 张风捷特烈 on 2020/4/25
/// contact me by email 1981462002@qq.com

import 'package:flutter/material.dart';
class ColorOfChip extends StatelessWidget {
  const ColorOfChip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      children: <Widget>[
        Chip(
          avatar: Image.asset("assets/images/icon_head.webp"),
          label: const Text("张风捷特烈"),
          padding: const EdgeInsets.all(5),
          labelPadding: const EdgeInsets.all(5),
          backgroundColor: Colors.grey.withAlpha(66),
          shadowColor: Colors.orangeAccent,
          elevation: 3,
        ),
        Chip(
          avatar: Image.asset("assets/images/icon_head.webp"),
          label: const Text("张风捷特烈"),
          padding: const EdgeInsets.all(5),
          labelPadding: const EdgeInsets.all(5),
          backgroundColor: Colors.cyanAccent.withAlpha(11),
          shadowColor: Colors.blue.withAlpha(88),
          elevation: 4,
        ),
      ],
    );
  }
}