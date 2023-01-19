import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-22
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 19,
//      "priority": 2,
//      "name": "RadioListTile选中色和密排",
//      "subtitle": "【activeColor】 : 选中时颜色  【Color】\n"
//          "【dense】: 是否密排   【bool】",
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

class DenseRadioListTile extends StatefulWidget {
  const DenseRadioListTile({Key? key}) : super(key: key);

  @override
  _DenseRadioListTileState createState() => _DenseRadioListTileState();
}

class _DenseRadioListTileState extends State<DenseRadioListTile> {
  final Map<ItemType, ItemBean> languages = {
    ItemType.java: ItemBean("Java", "曾经世界上最流行的语言", "assets/images/java.webp"),
    ItemType.kotlin:
        ItemBean("Kotlin", "未来世界上最流行的语言", "assets/images/kotlin.webp"),
    ItemType.dart: ItemBean("Dart", "世界上最优雅的语言", "assets/images/dart.webp"),
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
                    activeColor: Colors.orangeAccent,
                    dense: true,
                    subtitle: Text(languages[type]!.subTitle),
                    selected: _type == type,
                    secondary: CircleAvatar(
                      backgroundImage: AssetImage(languages[type]!.imgUrl),
                    ),
                    onChanged: (ItemType? type) =>
                        setState(() => _type = type ?? _type),
                  ))
              .toList()),
    );
  }
}