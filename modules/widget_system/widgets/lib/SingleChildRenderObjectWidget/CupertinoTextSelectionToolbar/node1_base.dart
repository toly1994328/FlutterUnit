import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com


class CupertinoTextSelectionToolbarDemo extends StatelessWidget {
  const CupertinoTextSelectionToolbarDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        width: 300,
        child: const Text(
          "注：此组件私有构造器，外部无法使用，并没有使用价值。",
          style: TextStyle(color: Colors.red, fontSize: 18),
        ),
    );
  }
}
