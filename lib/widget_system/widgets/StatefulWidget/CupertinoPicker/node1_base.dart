import 'package:flutter/cupertino.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 139,
//      "name": 'CupertinoPicker基本使用',
//      "priority": 1,
//      "subtitle":
//          "【children】 : 子组件列表   【List<Widget>】\n"
//          "【offAxisFraction】 : 轴偏移率   【double】\n"
//          "【squeeze】 : 挤压率   【double】\n"
//          "【diameterRatio】 : 高与圆柱直径比率   【double】\n"
//          "【itemExtent】 : 间距   【double】\n"
//          "【backgroundColor】 : 背景色   【Color】\n"
//          "【onSelectedItemChanged】 : 选中事件  【Function(int)】",
//    }
class CustomCupertinoPicker extends StatelessWidget {
  const CustomCupertinoPicker({Key? key}) : super(key: key);

  final List<String> names = const[
    'Java',
    'Kotlin',
    'Dart',
    'Swift',
    'C++',
    'Python',
    "JavaScript",
    "PHP",
    "Go",
    "Object-c"
  ];


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: CupertinoPicker(
          backgroundColor: CupertinoColors.systemGrey.withAlpha(33),
          diameterRatio: 1,
          offAxisFraction: 0.4,
          squeeze: 1.5,
          itemExtent: 40,
          onSelectedItemChanged: (position) {
            print('当前条目  ${names[position]}');
          },
          children: names.map((e) => Center(child: Text(e))).toList()),
    );
  }
}
