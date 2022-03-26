import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明: 

//    {
//      "widgetId": 148,
//      "name": 'Tab基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 子组件   【Widget】\n"
//          "【text】 : 文字   【String】\n"
//          "【icon】 : 下方组件  【Widgit】\n"
//          "    text和child不能同时存在",
//    }

class CustomTab extends StatelessWidget {
  const CustomTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        Tab(
          icon:Icon( Icons.add,color: Colors.blue,),
          child: Text('添加'),
        ),
        Tab(
          icon:Icon( Icons.close,color: Colors.red,),
          text: '删除',
        ),
        Tab(
          icon:Icon( Icons.refresh,color: Colors.green),
          text: '更新',
        ),
      ],
    );
  }
}
