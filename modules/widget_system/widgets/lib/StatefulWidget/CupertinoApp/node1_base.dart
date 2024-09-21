import 'package:flutter/cupertino.dart';

/// create by 张风捷特烈 on 2020-03-17
/// contact me by email 1981462002@qq.com

class CustomCupertinoApp extends StatelessWidget {
  const CustomCupertinoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 200,
      child: const CupertinoApp(
        title: 'Flutter Demo',
        theme: CupertinoThemeData(
          primaryColor: CupertinoColors.white,
        ),
        home: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: Icon(
              CupertinoIcons.reply,
              color: CupertinoColors.black,
            ),
            trailing: Icon(
              CupertinoIcons.share,
              color: CupertinoColors.black,
            ),
            middle: Text('Flutter Unit'),
          ),
          backgroundColor: CupertinoColors.systemBackground,
          child: Center(
            child: Text('Hello, World!'),
          ),
        ),
      ),
    );
  }
}
