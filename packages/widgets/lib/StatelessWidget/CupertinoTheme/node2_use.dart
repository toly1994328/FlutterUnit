import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 169,
//      "name": 'CupertinoThemeData的使用',
//      "priority": 2,
//      "subtitle":
//          "和Theme一样可以通过指定的属性，让它们在后代中共享，不过属性较少。注意如果需要使用主题，不能在当前的context中获取。",
//    }

class CustomCupertinoTheme extends StatelessWidget {
  const CustomCupertinoTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoTheme(
        data: CupertinoThemeData(
            primaryColor: Colors.blue, primaryContrastingColor: Colors.green),
        child: _ChildUseTheme());
  }
}

class _ChildUseTheme extends StatelessWidget {
  const _ChildUseTheme({Key? key}) : super(key: key);

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
          SizedBox(width: 150, child: Slider(value: 0.8, onChanged: (v) => {})),
          SizedBox(
              width: 150,
              child: Divider(
                color: CupertinoTheme.of(context).primaryContrastingColor,
                thickness: 1,
              ))
        ]);
  }
}