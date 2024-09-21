
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com


class StatefulBuilderDemo extends StatelessWidget {
  const StatefulBuilderDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int count = 0;

    return StatefulBuilder(
      builder: (ctx, setState) => ElevatedButton(
        child: Text("当前数字: $count"),
        onPressed: () {
          setState(() {
            count++;
          });
        },
      ),
    );
  }
}
