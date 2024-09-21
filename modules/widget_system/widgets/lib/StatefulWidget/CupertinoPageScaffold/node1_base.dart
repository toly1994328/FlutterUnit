import 'package:flutter/cupertino.dart';

/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com

class CustomCupertinoPageScaffold extends StatelessWidget {
  const CustomCupertinoPageScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 300,
      child: const CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: Icon(CupertinoIcons.reply),
          trailing: Icon(CupertinoIcons.share),
          middle: Text('Flutter Unit'),
        ),
        backgroundColor: CupertinoColors.systemBackground,
        child: Center(
          child: Text('Hello, World!'),
        ),
      ),
    );
  }
}