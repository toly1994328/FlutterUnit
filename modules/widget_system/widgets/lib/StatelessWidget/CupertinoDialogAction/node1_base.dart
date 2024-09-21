import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com

class CupertinoDialogActionDemo extends StatelessWidget {
  const CupertinoDialogActionDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoDialogAction(
          isDestructiveAction: false,
          onPressed: () => _toast(context),
          child: const Text('CupertinoDialogAction'),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () => _toast(context),
          child: const Text('CupertinoDialogAction'),
        ),
      ],
    );
  }

  void _toast(BuildContext context) {
    SnackBar snackBar = SnackBar(
      backgroundColor: Theme.of(context).primaryColor,
      content: const Text('CupertinoDialogAction'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }
}
