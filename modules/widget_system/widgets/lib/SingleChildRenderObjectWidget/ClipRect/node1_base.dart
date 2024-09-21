import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-04-19
/// contact me by email 1981462002@qq.com

class CustomClipRect extends StatelessWidget {
  const CustomClipRect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SizedBox(
        height: 100,
        width: 100,
        child: Image.asset(
          "assets/images/wy_300x200.webp",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
