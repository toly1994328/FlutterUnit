import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com

class TextDemo1 extends StatelessWidget {
  const TextDemo1({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle style =  TextStyle(
      color: Colors.blue,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      letterSpacing: 10,
    );
    return Container(
      width: 200,
      color: Colors.cyanAccent.withAlpha(33),
      height: 76,
      child: const Text("toly-张风捷特烈-1994`", style: style),
    );
  }
}