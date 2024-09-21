import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2023/11/28
/// contact me by email 1981462002@qq.com


class EndDrawerButtonDemo extends StatelessWidget {
  const EndDrawerButtonDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  EndDrawerButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue,
        iconColor: Colors.white,
      ),
    );
  }
}
