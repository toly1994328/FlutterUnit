import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com

class FallbackPlaceholder extends StatelessWidget {
  const FallbackPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const UnconstrainedBox(
      child:  Placeholder(
        color: Colors.blue,
        strokeWidth: 2,
        fallbackHeight: 100,
        fallbackWidth: 150,
      ),
    );
  }
}
