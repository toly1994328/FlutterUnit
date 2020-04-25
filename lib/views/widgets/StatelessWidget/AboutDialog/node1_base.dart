/// create by 张风捷特烈 on 2020/4/25
/// contact me by email 1981462002@qq.com
/// 说明:

///
//    {
//      "widgetId": 130,
//      "name": 'AboutDialog基本使用',
//      "priority": 1,
//      "subtitle":
//          "【applicationIcon】 : 左上图标   【Widget】\n"
//          "【applicationVersion】 : 版本号  【String】\n"
//          "【applicationName】 : 应用名  【String】\n"
//          "【applicationLegalese】 : 应用律术   【String】\n"
//          "【children】 : 子组件列表   【List<Widget>】",
//    }

import 'package:flutter/material.dart';

class CustomAboutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildAboutDialog(),
        Positioned(top: 50, right: 20, child: _buildRaisedButton(context)),
      ],
    );
  }

  Widget _buildRaisedButton(BuildContext context) => RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        color: Colors.blue,
        onPressed: () {
          showDialog(context: context, builder: (ctx) => _buildAboutDialog());
        },
        child: Text(
          'Just Show It',
          style: TextStyle(color: Colors.white),
        ),
      );

  AboutDialog _buildAboutDialog() {
    return AboutDialog(
      applicationIcon: FlutterLogo(),
      applicationVersion: 'v0.0.1',
      applicationName: 'Flutter Unit',
      applicationLegalese: 'Copyright© 2018-2020 张风捷特烈',
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(top: 20),
            width: 80,
            height: 80,
            child: Image.asset('assets/images/icon_head.png')),
        Container(
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            child: Text(
              'The King Of Coder.',
              style: TextStyle(color: Colors.white, fontSize: 20, shadows: [
                Shadow(
                    color: Colors.blue, offset: Offset(.5, .5), blurRadius: 3)
              ]),
            ))
      ],
    );
  }
}
