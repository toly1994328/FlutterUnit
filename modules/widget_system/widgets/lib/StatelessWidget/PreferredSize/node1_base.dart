import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/5/3
/// contact me by email 1981462002@qq.com

class CustomPreferredSize extends StatelessWidget {
  const CustomPreferredSize({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: AppBar(
            title: const Text('PreferredSize'),
          ),
        ),
      ),
    );
  }
}
