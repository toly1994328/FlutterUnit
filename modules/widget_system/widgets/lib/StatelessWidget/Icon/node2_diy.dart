import 'package:app/app.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/27
/// contact me by email 1981462002@qq.com



class MyIcon extends StatelessWidget {
  const MyIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        TolyIcon.icon_search,
        TolyIcon.icon_star,
        TolyIcon.icon_layout,
        TolyIcon.icon_star_ok
      ].map((e) => Icon(
        e,
        color: Colors.green,
        size: 60,
      ),).toList(),
    );
  }
}

