import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com

class TitleDemo extends StatelessWidget {
  const TitleDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Title(
      title: '张风捷特烈',
      color: const Color(0xFF9C27B0),
      child: const Center(
        child: Text('应用菜单栏中该页的名称为: 张风捷特烈'),
      ),
    );
  }
}
