import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2023/01/27
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 258,
//      "name": 'Badge 基本使用',
//      "priority": 1,
//      "subtitle": "【backgroundColor】 : 背景色   【Color?】\n"
//          "【textStyle】 : 标题颜色  【TextStyle?】\n"
//          "【textColor】 : 标题样式  【Color?】\n"
//          "【padding】 : 标题边距  【EdgeInsetsGeometry?】\n"
//          "【alignment】 : 标题偏移   【AlignmentDirectional?】\n"
//          "【smallSize】 : 无标签时尺寸   【double?】\n"
//          "【largeSize】 : 有标签时高度   【double?】\n"
//          "【label】 : 标题组件   【Widget?】\n"
//          "【child】 : 子组件   【Widget?】",
//    }

class BadgeDemo extends StatelessWidget {
  const BadgeDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      children: const [
        Badge(
          backgroundColor: Colors.redAccent,
          alignment: AlignmentDirectional(0,-2),
          smallSize: 10,
          child: Icon(Icons.update,size: 36,color: Colors.green,),
        ),
        Badge(
          backgroundColor: Colors.red,
          label: Text('99'),
          alignment: AlignmentDirectional(36-16,-2),
          largeSize: 14,
          smallSize: 6,
          child: Icon(Icons.message,size: 36,),
        ),
        Badge(
          backgroundColor: Colors.orange,
          label: Text('999+'),
          alignment: AlignmentDirectional(36-16,-2),
          largeSize: 14,
          smallSize: 6,
          child: Icon(Icons.supervised_user_circle,size: 36,),
        ),
      ],
    );
  }
}
