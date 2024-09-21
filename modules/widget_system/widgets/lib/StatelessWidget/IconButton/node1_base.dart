import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020/4/27
/// contact me by email 1981462002@qq.com


class CustomIconButton extends StatelessWidget {
  const CustomIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        padding: const EdgeInsets.only(),
        onPressed: () {},
        icon: const Icon(Icons.android, size: 40, color: Colors.green),
        tooltip: "android",
        highlightColor: Colors.orangeAccent,
        splashColor: Colors.blue,
      ),
    );
  }
}
