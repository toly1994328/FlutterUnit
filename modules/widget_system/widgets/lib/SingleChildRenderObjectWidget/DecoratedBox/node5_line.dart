import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/30
/// contact me by email 1981462002@qq.com

class UnderlineTabIndicatorDemo extends StatelessWidget {
  const UnderlineTabIndicatorDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: UnderlineTabIndicator(
          insets: EdgeInsets.symmetric(horizontal: 5, vertical: -5),
          borderSide: BorderSide(color: Colors.orange, width: 2)),
      child: Icon(
        Icons.ac_unit,
        color: Colors.blue,
        size: 40,
      ),
    );
  }
}