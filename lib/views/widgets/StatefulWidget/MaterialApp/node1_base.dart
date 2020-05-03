import 'package:flutter/material.dart';
import '../../../../app/router.dart';
import '../../StatefulWidget/Scaffold/node1_base.dart';

/// create by 张风捷特烈 on 2020-03-17
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 65,
//      "name": 'MaterialApp基本用法',
//      "priority": 1,
//      "subtitle":
//          "【theme】 : 主题   【ThemeData】\n"
//          "【title】 : 任务栏标题   【String】\n"
//          "【onGenerateRoute】 : 路由生成器   【RouteFactory】\n"
//          "【home】 : 主页   【Widget】",
//    }
class CustomMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 200,
      child: MaterialApp(
        title: 'Flutter Demo',
        onGenerateRoute: Router.generateRoute,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CustomScaffold(),
      ),
    );
  }
}
