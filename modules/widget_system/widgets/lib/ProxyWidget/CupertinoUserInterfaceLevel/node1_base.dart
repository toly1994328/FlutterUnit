import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com


class CupertinoUserInterfaceLevelDemo extends StatelessWidget {
  const CupertinoUserInterfaceLevelDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoUserInterfaceLevel(
      data: CupertinoUserInterfaceLevelData.elevated,
      child: LevelShower()
    );
  }

}

class LevelShower extends StatelessWidget {
  const LevelShower({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CupertinoUserInterfaceLevelData data = CupertinoUserInterfaceLevel.of(context);
    return Container(
      height: 150,
      alignment: Alignment.center,
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      child: Text(data.toString()),
    );
  }
}


