import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 168,
//      "name": '文字样式-TextTheme',
//      "priority": 1,
//      "subtitle":
//          "",
//    }
class TextCupertinoTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var queryData = CupertinoTheme.of(context).textTheme;
    var styles = {
      "tabLabelTextStyle: ": queryData.tabLabelTextStyle,
      "actionTextStyle: ": queryData.actionTextStyle,
      "navActionTextStyle: ": queryData.navActionTextStyle,
      "textStyle: ": queryData.textStyle,
      "navTitleTextStyle: ": queryData.navTitleTextStyle,
      "pickerTextStyle: ": queryData.pickerTextStyle,
      "dateTimePickerTextStyle: ": queryData.dateTimePickerTextStyle,
      "navLargeTitleTextStyle: ": queryData.navLargeTitleTextStyle,
    };

    return Container(
      child: Column(
        children: styles.keys.map((e) => buildItem(e, styles[e])).toList(),
      ),
    );
  }

  Widget buildItem(String e, TextStyle style) => Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  e,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "@toly",
                  style: style,
                )
              ],
            ),
          ),
          Divider(
            height: 1,
          )
        ],
      );
}

//    {
//      "widgetId": 169,
//      "name": 'CupertinoThemeData的使用',
//      "priority": 2,
//      "subtitle":
//          "和Theme一样可以通过指定的属性，让它们在后代中共享，不过属性较少。注意如果需要使用主题，不能在当前的context中获取。",
//    }

class CustomCupertinoTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
        data: CupertinoThemeData(
           primaryColor: Colors.blue,
               primaryContrastingColor: Colors.green
        ),
          child: _ChildUseTheme());
  }
}

class _ChildUseTheme extends StatelessWidget {
  const _ChildUseTheme({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
        Container(
              width: 50,
              height: 50,
              color: CupertinoTheme.of(context).primaryContrastingColor,
            ),
          Container(
              width: 150,
              child: Slider(value: 0.8, onChanged: (v) => {})),
          Container(  width: 150,child: Divider(color:CupertinoTheme.of(context).primaryContrastingColor,thickness: 1,))
        ]);
  }
}
