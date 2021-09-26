import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/5/3
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 202,
//      "name": 'Builder的使用',
//      "priority": 1,
//      "subtitle": "【builder】 : 组件构造器   【WidgetBuilder】\n"
//          "同一个类中使用`XXX.of(context)`获取某类状态对象方法会存在`上下文滞后`的错误，使用Builder解决。",
//    }

class BuilderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Builder'),
        ),
        floatingActionButton: Builder(
          builder: (ctx) => FloatingActionButton(
            onPressed: () {
              Scaffold.of(ctx)
                  .showSnackBar(SnackBar(content: Text('hello builder')));
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }


}
