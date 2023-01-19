import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 168,
//      "name": '文字样式-ThemeData#TextTheme',
//      "priority": 1,
//      "subtitle":
//          "子组件可以通过ThemeData.of获取主题的数据进行使用。",
//    }
class TextThemeDemo extends StatelessWidget {
  const TextThemeDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme queryData = Theme.of(context).textTheme;
    Map<String, TextStyle> styles = {
      "headline1: ": queryData.headline1!,
      "headline2: ": queryData.headline2!,
      "headline3: ": queryData.headline3!,
      "headline4: ": queryData.headline4!,
      "headline5: ": queryData.headline5!,
      "headline6: ": queryData.headline6!,
      "button: ": queryData.button!,
      "overline: ": queryData.overline!,
      "subtitle1: ": queryData.subtitle1!,
      "subtitle2: ": queryData.subtitle2!,
      "caption: ": queryData.caption!,
      "bodyText1: ": queryData.bodyText1!,
      "bodyText2: ": queryData.bodyText2!,
    };

    return Column(
      children: styles.keys
          .map((String styleInfo) => buildItem(styleInfo, styles[styleInfo]!))
          .toList(),
    );
  }

  TextStyle get textStyle => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );

  Widget buildItem(String styleInfo, TextStyle style) => Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(styleInfo, style: textStyle),
                Text("@toly", style: style)
              ],
            ),
          ),
          const Divider(height: 1)
        ],
      );
}