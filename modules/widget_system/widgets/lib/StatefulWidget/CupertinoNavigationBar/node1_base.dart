import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com

class CustomCupertinoNavigationBar extends StatelessWidget {
  const CustomCupertinoNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      leading: const Icon(
        CupertinoIcons.back,
        size: 25,
        color: Colors.blue,
      ),
      middle: const Text("风雪雅舍"),
      trailing: Image.asset(
        "assets/images/icon_head.webp",
        width: 25.0,
        height: 25.0,
      ),
      backgroundColor: const Color(0xfff1f1f1),
      padding: const EdgeInsetsDirectional.only(start: 10,end: 20),
      border: Border.all(color: Colors.transparent),
    );
  }
}
