import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 167,
//      "name": 'MediaQuery获取数据信息',
//      "priority": 1,
//      "subtitle": "MediaQuery.of(context)可以获取MediaQueryData",
//    }

class CustomMediaQuery extends StatelessWidget {
  const CustomMediaQuery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    Map<String,Object> data = {
      "size": queryData.size,
      "devicePixelRatio": queryData.devicePixelRatio.toStringAsFixed(1),
      "textScaleFactor": queryData.textScaleFactor.toStringAsFixed(1),
      "platformBrightness": queryData.platformBrightness,
      "padding": queryData.padding,
      "viewInsets": queryData.viewInsets,
      "systemGestureInsets": queryData.padding,
      "viewPadding": queryData.padding,
      "physicalDepth": queryData.padding,
      "alwaysUse24HourFormat": queryData.padding,
      "accessibleNavigation": queryData.alwaysUse24HourFormat,
      "invertColors": queryData.invertColors,
      "highContrast": queryData.highContrast,
      "disableAnimations": queryData.disableAnimations,
      "boldText": queryData.boldText,
    };

    return Container(
      height: 200,
      color: Colors.grey.withAlpha(11),
      child:ListView(
          children: data.keys.map((e) => buildItem(e, data)).toList(),
      ),
    );
  }

  Widget buildItem(String e, Map<String, Object> data) => Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  e,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  data[e].toString(),
                  style: const TextStyle(fontSize: 16, color: Colors.orange),
                )
              ],
            ),
          ),
          const Divider(
            height: 1,
          )
        ],
      );
}


