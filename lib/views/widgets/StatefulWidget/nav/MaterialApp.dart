import 'package:flutter/material.dart';
import 'package:flutter_unit/app/router.dart';
import 'package:flutter_unit/views/pages/nav_page.dart';
import 'package:flutter_unit/views/widgets/StatefulWidget/nav/Scaffold.dart';

/// create by 张风捷特烈 on 2020-03-17
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 65,
//      "name": 'MaterialApp基本用法',
//      "priority": 1,
//      "subtitle":
//          "【theme】 : 主题   【ThemeData】\n"
//          "【title】 : 底部组件   【任务栏标题】\n"
//          "【onGenerateRoute】 : 路由生成器   【RouteFactory】\n"
//          "【home】 : 主页   【Widget】"
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
