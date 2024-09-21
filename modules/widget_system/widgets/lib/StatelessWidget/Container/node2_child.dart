import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/25
/// contact me by email 1981462002@qq.com

class ContainerWithChild extends StatelessWidget {
  const ContainerWithChild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(10),
      width: 200,
      height: 200 * 0.618,
      color: Colors.grey.withAlpha(88),
      child: const Icon(Icons.android),
    );
  }
}