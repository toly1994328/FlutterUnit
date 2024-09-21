import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-04-01
/// contact me by email 1981462002@qq.com

class CustomTooltip extends StatelessWidget {
  const CustomTooltip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Tooltip(
      preferBelow: true,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(5),
      message: "天王盖地虎",
      showDuration: Duration(seconds: 3),
      waitDuration: Duration(milliseconds: 200),
      child: Icon(Icons.info_outline),
    );
  }
}
