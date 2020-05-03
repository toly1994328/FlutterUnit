/// create by 张风捷特烈 on 2020/4/30
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 5,
//      "priority": 1,
//      "name": "用于显示一个角标",
//      "subtitle": "【message】 : 显示的文字信息  【String】\n"
//          "【location】 : 位置*4  【BannerLocation】\n"
//          "【color】: 角标颜色   【Color】\n"
//          "【child】: 孩子   【Widget】\n"
//          "【textStyle】: 文字样式   【TextStyle】",
//    }

import 'package:flutter/material.dart';

class CustomBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = {
      BannerLocation.topStart: Colors.red,
      BannerLocation.topEnd: Colors.blue,
      BannerLocation.bottomStart: Colors.green,
      BannerLocation.bottomEnd: Colors.yellow,
    };

    return Wrap(
        spacing: 10,
        runSpacing: 10,
        children: data.keys.map((e) =>
            Container(
              color: Color(0xffD8F5FF),
              width: 150,
              height: 150 * 0.618,
              child: Banner(
                message: "Flutter 1.12发布",
                location: e,
                color: data[e],
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: FlutterLogo(colors: Colors.blue,
                      style: FlutterLogoStyle.horizontal,)),
              ),
            )).toList());
  }
}
