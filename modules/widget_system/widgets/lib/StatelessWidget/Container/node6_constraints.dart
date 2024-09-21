import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/25
/// contact me by email 1981462002@qq.com

class ContainerConstraints extends StatelessWidget {
  const ContainerConstraints({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      width: 200,
      height: 200 * 0.618,
      constraints: const BoxConstraints(
        minWidth: 100,
        maxWidth: 150,
        minHeight: 20,
        maxHeight: 100,
      ),
    );
  }
}