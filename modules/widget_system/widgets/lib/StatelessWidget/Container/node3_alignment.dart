import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/25
/// contact me by email 1981462002@qq.com

class ContainerAlignment extends StatelessWidget {
  const ContainerAlignment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      width: 200,
      height: 200 * 0.618,
      color: Colors.grey.withAlpha(88),
      child: const Icon(
        Icons.android,
        color: Colors.green,
      ),
    );
  }
}