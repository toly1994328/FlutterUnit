import 'package:flutter/cupertino.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com

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
