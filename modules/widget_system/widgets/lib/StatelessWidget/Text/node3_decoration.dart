import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com

class DecorationText extends StatelessWidget {
  const DecorationText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "19940328",
      style: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
          decorationThickness: 3,
          decorationStyle: TextDecorationStyle.wavy,
          decorationColor: Colors.blue,
          fontStyle: FontStyle.italic,
          fontFamily: "DancingScript",
          letterSpacing: 10),
    );
  }
}