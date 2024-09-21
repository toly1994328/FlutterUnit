import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com


class CupertinoNavigationBarBackButtonDemo extends StatelessWidget {
  const CupertinoNavigationBarBackButtonDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBarBackButton(
      color: Colors.deepPurpleAccent,
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
