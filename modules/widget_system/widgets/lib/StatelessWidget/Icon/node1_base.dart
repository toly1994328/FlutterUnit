

import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/27
/// contact me by email 1981462002@qq.com



class CustomIcon extends StatelessWidget {
  const CustomIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: const [
        Icon(Icons.send, color: Colors.orange, size: 60),
        Icon(Icons.android, color: Colors.green, size: 100),
      ],
    );
  }
}