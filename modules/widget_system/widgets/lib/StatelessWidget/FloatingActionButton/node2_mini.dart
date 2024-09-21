/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com


import 'package:flutter/material.dart';

class MiniFAB extends StatelessWidget {
  const MiniFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<Color,IconData> data = {
      Colors.red: Icons.add,
      Colors.blue: Icons.bluetooth,
      Colors.green: Icons.android,
    };
    return Wrap(
        spacing: 20,
        children: data.keys
            .map((e) => FloatingActionButton(
          heroTag:  e.toString()+"b",
          onPressed: () {},
          backgroundColor: e,
          mini: true,
          foregroundColor: Colors.white,
          child: Icon(data[e]),
          tooltip: "android",
          elevation: 5, //z-阴影盖度
        )).toList());
  }
}