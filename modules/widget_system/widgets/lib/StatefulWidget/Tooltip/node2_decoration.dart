import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-04-01
/// contact me by email 1981462002@qq.com

class DecorationTooltip extends StatelessWidget {
  const DecorationTooltip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Tooltip(
        preferBelow: false,
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(2),
        message: "宝塔镇河妖",
        textStyle: TextStyle(
            color: Colors.red,
            shadows: [Shadow(color: Colors.white,
                offset: Offset(1, 1))]),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.orangeAccent,
              offset: Offset(1, 1), blurRadius: 8)
        ]),
        child: Icon(Icons.info_outline));
  }
}
