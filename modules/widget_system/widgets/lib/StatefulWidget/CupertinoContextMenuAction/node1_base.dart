/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com

import 'package:flutter/cupertino.dart';

class CustomCupertinoContextMenuAction extends StatelessWidget {
  const CustomCupertinoContextMenuAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 200,
          margin: const EdgeInsets.all(5),
          child: CupertinoContextMenuAction(
              trailingIcon: CupertinoIcons.settings,
              isDefaultAction: true,
              onPressed: () =>  Navigator.of(context).pushNamed('AboutMePage'),
              child: const Text('张风捷特烈')),
        ),
        Container(
          width: 200,
          margin: const EdgeInsets.all(5),
          child: CupertinoContextMenuAction(
              trailingIcon: CupertinoIcons.home,
              isDefaultAction: false,
              onPressed: () =>  Navigator.of(context).pushNamed('AboutMePage'),
              child: const Text('百里·巫缨')),
        ),
      ],
    );
  }
}
