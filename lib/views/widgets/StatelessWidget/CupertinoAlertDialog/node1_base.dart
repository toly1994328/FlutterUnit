
/// create by 张风捷特烈 on 2020-03-24
/// contact me by email 1981462002@qq.com
/// 说明:
///
//    {
//      "widgetId": 129,
//      "name": 'CupertinoAlertDialog基本使用',
//      "priority": 1,
//      "subtitle":
//          "【title】 : 顶部组件   【Widget】\n"
//          "【content】 : 内容组件  【Widget】\n"
//          "【actions】 : 顶部文字样式  【List<Widget>】",
//    }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCupertinoAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildRaisedButton(context),
        _buildCupertinoAlertDialog(context),
      ],
    );
  }

  Widget _buildRaisedButton(BuildContext context) => RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        color: Colors.blue,
        onPressed: () {
          showDialog(
              context: context,
              builder: (ctx) => _buildCupertinoAlertDialog(context));
        },
        child: Text(
          'Just Show It !',
          style: TextStyle(color: Colors.white),
        ),
      );

  Widget _buildCupertinoAlertDialog(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: CupertinoAlertDialog(
          title: _buildTitle(context),
          content: _buildContent(),
          actions: <Widget>[
            CupertinoButton(
              child: Text("Yes, Delete"),
              onPressed: () => Navigator.pop(context),
            ),
            CupertinoButton(
              child: Text("Cancle"),
              onPressed: () => Navigator.pop(context),
            ),
          ]),
    );
  }

  Widget _buildTitle(context) {
    return Row(
        //标题
        children: <Widget>[
          Icon(
            CupertinoIcons.delete_solid,
            color: Colors.red,
          ),
          Expanded(
              child: Text(
            'Delete File',
            style: TextStyle(color: Colors.red, fontSize: 20),
          )),
          InkWell(
            child: Icon(CupertinoIcons.clear_thick),
            onTap: () => Navigator.pop(context),
          )
        ]);
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Column(
        children: <Widget>[
          Text(
            '    Hi toly! If you push the conform buttom ,'
            ' You will lose this file. Are you sure wand to do that?',
            style: TextStyle(color: Color(0xff999999), fontSize: 16),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
