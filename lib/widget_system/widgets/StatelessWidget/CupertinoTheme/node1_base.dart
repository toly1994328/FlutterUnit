
/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TextCupertinoTheme extends StatelessWidget {
  const TextCupertinoTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CupertinoTextThemeData queryData = CupertinoTheme.of(context).textTheme;
    Map<String, TextStyle> styles = {
      "tabLabelTextStyle: ": queryData.tabLabelTextStyle,
      "actionTextStyle: ": queryData.actionTextStyle,
      "navActionTextStyle: ": queryData.navActionTextStyle,
      "textStyle: ": queryData.textStyle,
      "navTitleTextStyle: ": queryData.navTitleTextStyle,
      "pickerTextStyle: ": queryData.pickerTextStyle,
      "dateTimePickerTextStyle: ": queryData.dateTimePickerTextStyle,
      "navLargeTitleTextStyle: ": queryData.navLargeTitleTextStyle,
    };
    TextStyle style =
        const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    return Column(
      children:
          styles.keys.map((e) => buildItem(e, style, styles[e]!)).toList(),
    );
  }

  Widget buildItem(String label, TextStyle labelStyle, TextStyle style) =>
      Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(label, style: labelStyle),
                Text("@toly", style: style)
              ],
            ),
          ),
          const Divider(height: 1)
        ],
      );
}