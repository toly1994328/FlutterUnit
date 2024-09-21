

/// create by 张风捷特烈 on 2020/4/25
/// contact me by email 1981462002@qq.com


import 'package:flutter/material.dart';
class CustomChip extends StatelessWidget {
  const CustomChip({Key? key}) : super(key: key);

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
        ),
        const Chip(
          avatar: CircleAvatar(
              backgroundImage:
              AssetImage("assets/images/wy_200x300.webp")),
          label: Text("百里巫缨"),
          padding: EdgeInsets.all(8),
          labelPadding: EdgeInsets.all(6),
        ),
      ],
    );
  }
}