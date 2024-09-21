import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/30
/// contact me by email 1981462002@qq.com


class FlutterLogoDecorationDemo extends StatelessWidget {
  const FlutterLogoDecorationDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: FlutterLogoDecoration(
//          darkColor: Colors.orange,
//          lightColor: Colors.deepPurpleAccent,
          margin: EdgeInsets.all(8),
          style: FlutterLogoStyle.stacked),
      child: SizedBox(
        width: 100,
        height: 100,
      ),
    );
  }
}
