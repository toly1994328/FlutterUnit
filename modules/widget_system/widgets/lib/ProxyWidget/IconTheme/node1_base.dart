import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-12
/// contact me by email 1981462002@qq.com

class IconThemeDemo extends StatelessWidget {
  const IconThemeDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: const IconThemeData(
          color: Colors.purple,
          opacity: 1.0,
          size: 30
      ),
      child: Wrap(
        spacing: 10,
        children: const[
          Icon(Icons.add),
          Icon(Icons.ac_unit),
          Icon(Icons.g_translate),
          Icon(Icons.remove)
        ],
      ),
    );
  }
}