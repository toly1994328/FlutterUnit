import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com

class TextDemo2 extends StatelessWidget {
  const TextDemo2({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle style = TextStyle(
        fontSize: 50,
        color: Colors.white,
        backgroundColor: Colors.black,
        shadows: [
          Shadow(color: Colors.cyanAccent, offset: Offset(1, 1), blurRadius: 10),
          Shadow(color: Colors.blue, offset: Offset(-0.1, 0.1), blurRadius: 10),
        ]);
    return const Text("张风捷特烈", style: style);
  }
}
