import 'package:flutter/material.dart';
import 'package:flutter_unit/components/panel/panel.dart';

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
  @override
  _CustomRadioListTileState createState() => _CustomRadioListTileState();
}

class _CustomRadioListTileState extends State<CustomRadioListTile> {
  final Map<ItemType, ItemBean> languages = {
    ItemType.java:
    ItemBean("Java", "曾经世界上最流行的语言", "assets/images/java.jpeg"),
    ItemType.kotlin:
    ItemBean("Kotlin", "未来世界上最流行的语言", "assets/images/kotlin.jpg"),
    ItemType.dart:
    ItemBean("Dart", "世界上最优雅的语言", "assets/images/dart.jpg"),
  };
  var _type = ItemType.java;

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
                    title: Text(languages[type].title),
                    subtitle: Text(languages[type].subTitle),
                    selected: _type == type,
                    secondary: CircleAvatar(
                      backgroundImage: AssetImage(languages[type].imgUrl),
                    ),
                    onChanged: (type) => setState(() => _type = type),
                  ))
              .toList()),
    );
  }
}

class DenseRadioListTile extends StatefulWidget {
  @override
  _DenseRadioListTileState createState() => _DenseRadioListTileState();
}

class _DenseRadioListTileState extends State<DenseRadioListTile> {
  final Map<ItemType, ItemBean> languages = {
    ItemType.java:
    ItemBean("Java", "曾经世界上最流行的语言", "assets/images/java.jpeg"),
    ItemType.kotlin:
    ItemBean("Kotlin", "未来世界上最流行的语言", "assets/images/kotlin.jpg"),
    ItemType.dart:
    ItemBean("Dart", "世界上最优雅的语言", "assets/images/dart.jpg"),
  };
  var _type = ItemType.java;

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
            title: Text(languages[type].title),
            activeColor: Colors.orangeAccent,
            dense: true,
            subtitle: Text(languages[type].subTitle),
            selected: _type == type,
            secondary: CircleAvatar(
              backgroundImage: AssetImage(languages[type].imgUrl),
            ),
            onChanged: (type) => setState(() => _type = type),
          ))
              .toList()),
    );
  }
}


//class RadioListTilePage extends StatefulWidget {
//  @override
//  _RadioListTilePageState createState() => _RadioListTilePageState();
//}
//
//class _RadioListTilePageState extends State<RadioListTilePage> {
//
//    final Map<ItemType,ItemBean> languages={
//      ItemType.java: ItemBean("Java", "曾经世界上最流行的语言", "assets/images/java.jpeg"),
//      ItemType.kotlin: ItemBean("Kotlin", "未来世界上最流行的语言", "assets/images/kotlin.jpg"),
//      ItemType.dart: ItemBean("Dart", "世界上最优雅的语言", "assets/images/dart.jpg"),
//    };
//    var _type=ItemType.java;
//  @override
//  Widget build(BuildContext context) {
//
//    return Container(
//      color: Colors.grey.withAlpha(11),
//      child: Column(
//        mainAxisSize: MainAxisSize.min,
//        children: languages.keys.map((type)=>RadioListTile<ItemType>(
//          value: type,
//          groupValue: _type,
//          title: Text(languages[type].title),
//          subtitle: Text(languages[type].subTitle),
//          selected: _type==type,
//          secondary: CircleAvatar(
//              backgroundImage: AssetImage(languages[type].imgUrl),),
//          onChanged: (type)=> setState(() => _type=type),
//        )).toList()
//      ),
//    );
//  }
//}
//
//enum ItemType{
//  java,
//  kotlin,
//  dart,
//}
//class ItemBean{
// final String title;
// final String subTitle;
// final String imgUrl;
// ItemBean(this.title, this.subTitle, this.imgUrl);
//}

//class LanguageChooser extends StatelessWidget{
//
//  @override
//  Widget build(BuildContext context) {
//
//    var map =<Locale,String>{
//      LocaleState.zh().locale:"java",
//      LocaleState.en().locale:I18N.of(context).english,
//      LocaleState.fr().locale:I18N.of(context).french,
//    };
//
//    return  StoreBuilder<AppState>(builder: (context, store) =>ExpansionTile(
//      title: Text(I18N.of(context).switchLocal),
//      leading: Icon(Icons.language,color: store.state.themeState.primaryColor,),
//      children: map.keys.map((local)=>RadioListTile(
//          activeColor: store.state.themeState.primaryColor,
//          value: local,
//          title: Text(map[local]),
//          groupValue: store.state.localeState.locale,
//          onChanged: (locale)=> store.dispatch(ActionSwitchLocal(locale))
//      )).toList(),
//    ));
//  }
//}
