import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-22
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 19,
//      "priority": 1,
//      "name": "RadioListTile需要一个泛型T",
//      "subtitle": "【value】 : 条目对象  【T】\n"
//          "【groupValue】 : 选中对象  【T】\n"
//          "【selected】: 是否选中   【bool】\n"
//          "【secondary】: 右侧组件   【Widget】\n"
//          "【title】: 中间上组件   【Widget】\n"
//          "【subtitle】: 中间下组件   【Widget】\n"
//          "【onChanged】: 切换事件   【Function(T)】",
//    }

enum ItemType {
  java,
  kotlin,
  dart,
}

class ItemBean {
  final String title;
  final String subTitle;
  final String imgUrl;

  ItemBean(this.title, this.subTitle, this.imgUrl);
}

class CustomRadioListTile extends StatefulWidget {
  const CustomRadioListTile({Key? key}) : super(key: key);

  @override
  _CustomRadioListTileState createState() => _CustomRadioListTileState();
}

class _CustomRadioListTileState extends State<CustomRadioListTile> {
  final Map<ItemType, ItemBean> languages = {
    ItemType.java:
    ItemBean("Java", "曾经世界上最流行的语言", "assets/images/java.webp"),
    ItemType.kotlin:
    ItemBean("Kotlin", "未来世界上最流行的语言", "assets/images/kotlin.webp"),
    ItemType.dart:
    ItemBean("Dart", "世界上最优雅的语言", "assets/images/dart.webp"),
  };
  ItemType _type = ItemType.java;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withAlpha(11),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: languages.keys
              .map((type) => RadioListTile<ItemType>(
            value: type,
            groupValue: _type,
            title: Text(languages[type]!.title),
            subtitle: Text(languages[type]!.subTitle),
            selected: _type == type,
            secondary: CircleAvatar(
              backgroundImage: AssetImage(languages[type]!.imgUrl),
            ),
            onChanged: (ItemType? type) => setState(() => _type = type?? _type),
          ))
              .toList()),
    );
  }
}
