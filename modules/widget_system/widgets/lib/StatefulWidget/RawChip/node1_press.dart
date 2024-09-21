import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com

class PressRawChip extends StatelessWidget {
  const PressRawChip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawChip(
      padding: const EdgeInsets.all(5),
      labelPadding: const EdgeInsets.all(3),
      label: const Text('张风捷特烈'),
      avatar: Image.asset("assets/images/icon_head.webp"),
      elevation: 3,
      pressElevation: 5,
      shadowColor: Colors.orangeAccent,
      onPressed: () =>  Navigator.of(context).pushNamed('AboutMePage'),
    );
  }
}
