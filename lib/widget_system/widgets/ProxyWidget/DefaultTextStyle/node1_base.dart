
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-12
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 324,
//      "name": 'DefaultTextStyle使用',
//      "priority": 1,
//      "subtitle": "各属性同Text，详见之。\n"
//          "其功能是: 设置默认的文字样式应用于【后代组件】,注意后代组件也可以指定自身的样式",
//    }
class DefaultTextStyleDemo extends StatelessWidget {
  const DefaultTextStyleDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
          fontSize: 18,
          color: Colors.blue,
          decoration: TextDecoration.underline),
      child: Wrap(
        spacing: 5,
        children: const[
          Text("Hello,",),
          FlutterLogo(),
          Text("Flutter",style: TextStyle(color: Colors.red),),
          Text("Unit."),
        ],
      ),
    );
  }
}
