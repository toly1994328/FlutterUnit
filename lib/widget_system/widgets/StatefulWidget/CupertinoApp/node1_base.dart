import 'package:flutter/cupertino.dart';

/// create by 张风捷特烈 on 2020-03-17
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 156,
//      "name": 'CupertinoApp基本用法',
//      "priority": 1,
//      "subtitle": "【theme】 : 主题   【ThemeData】\n"
//          "【title】 : 任务栏标题   【String】\n"
//          "【onGenerateRoute】 : 路由生成器   【RouteFactory】\n"
//          "【home】 : 主页   【Widget】",
//    }
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
