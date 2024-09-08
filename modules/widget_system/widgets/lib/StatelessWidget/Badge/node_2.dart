import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2023/01/27
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 258,
//      "name": 'Badge 标签标记',
//      "priority": 2,
//      "subtitle":  "【label】 : 标题组件   【Widget?】\n"
//          "【textStyle】 : 标题颜色  【TextStyle?】\n"
//          "【textColor】 : 标题样式  【Color?】\n"
//          "【padding】 : 标题边距  【EdgeInsetsGeometry?】\n"
//          "【largeSize】 : 有标签时高度   【double?】\n",
//    }

class BadgeLabelDemo extends StatelessWidget {
  const BadgeLabelDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Badge(
      backgroundColor: Colors.red,
      label: Text('99'),
      textStyle: TextStyle(fontSize: 8,color: Colors.red),
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
      largeSize: 14,
      child: Icon(Icons.message,size: 36,color: Colors.indigo,),
    );
  }
}

