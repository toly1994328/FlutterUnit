
import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-04-19
/// contact me by email 1981462002@qq.com

class CustomCenter extends StatelessWidget {
  const CustomCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(5),
        width: 200,
        height: 100,
        color: Colors.grey.withAlpha(88),
        child: Center(
            child: Container(
          width: 80,
          height: 60,
          color: Colors.cyanAccent,
        )));
  }
}
