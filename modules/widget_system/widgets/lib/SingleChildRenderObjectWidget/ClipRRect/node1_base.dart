import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-04-19
/// contact me by email 1981462002@qq.com

class CustomClipRRect extends StatelessWidget {
  const CustomClipRRect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.elliptical(35, 30)),
      child: Image.asset(
        "assets/images/wy_300x200.webp",
        width: 150,
        height: 100,
      ),
    );
  }
}
