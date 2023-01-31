
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 242 StatefulBuilder 需要传入 builder 属性进行构造组件，在 builder 中可以使用 StateSetter 改变构造子组件的状态，即可以不用创建类而实现一个局部刷新的组件。
//    {
//      "widgetId": 242,
//      "name": 'StatefulBuilder基本使用',
//      "priority": 1,
//      "subtitle":
//          "【builder】 : 组件构造器   【StatefulWidgetBuilder】",
//    }

class StatefulBuilderDemo extends StatelessWidget {
  const StatefulBuilderDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int count = 0;

    return StatefulBuilder(
      builder: (ctx, setState) => ElevatedButton(
        child: Text("当前数字: $count"),
        onPressed: () {
          setState(() {
            count++;
          });
        },
      ),
    );
  }
}
