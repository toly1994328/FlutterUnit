import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com


class LongPressMaterialButton extends StatelessWidget {
  const LongPressMaterialButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        height: 40,
        elevation: 5,
        color: Colors.blue,
        highlightColor: Colors.green,
        textColor: Colors.white,
        padding: const EdgeInsets.all(8),
        child: const Text("MaterialButton"),
        onLongPress: () =>  Navigator.of(context).pushNamed('AboutMePage'),
        onPressed: () => Navigator.of(context).pushNamed('AboutMePage'));
  }
}