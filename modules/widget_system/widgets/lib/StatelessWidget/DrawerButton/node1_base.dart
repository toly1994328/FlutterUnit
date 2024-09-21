import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2023/11/28
/// contact me by email 1981462002@qq.com


class DrawerButtonDemo extends StatelessWidget {
  const DrawerButtonDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  DrawerButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue,
        iconColor: Colors.white,
      ),
    );
  }
}
