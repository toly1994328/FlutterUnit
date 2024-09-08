
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 193,
//      "name": 'AboutListTile基本使用',
//      "priority": 1,
//      "subtitle":
//          "【icon】 : 左图标   【Widget】\n"
//          "【applicationIcon】 : 左上图标   【Widget】\n"
//          "【applicationVersion】 : 版本号  【String】\n"
//          "【applicationName】 : 应用名  【String】\n"
//          "【applicationLegalese】 : 应用律术   【String】\n"
//          "【aboutBoxChildren】 : 弹框内容组件   【List<Widget>】",
//    }

class AboutListTileDemo extends StatelessWidget {
  const AboutListTileDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AboutListTile(
      icon:  Icon(Icons.info),
      applicationIcon:  FlutterLogo(),
      applicationName: 'Flutter Unit',
      applicationVersion: 'v0.0.1',
      applicationLegalese: 'Copyright© 2018-2024 张风捷特烈',
      aboutBoxChildren: [
         Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            '      FlutterUnit是【张风捷特烈】的开源项目，'
                '收录Flutter的300+组件，并附加详细介绍以及操作交互，'
                '希望帮助广大编程爱好者入门Flutter。'
                '更多知识可以关注掘金账号、公众号【编程之王】。',
            style: TextStyle(color: Color(0xff999999), fontSize: 16),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}