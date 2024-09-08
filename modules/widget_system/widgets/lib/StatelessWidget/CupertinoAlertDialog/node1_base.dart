import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 129,
//      "name": 'CupertinoActionSheetAction基本使用',
//      "priority": 1,
//      "subtitle": "【child】 : 子组件   【Widget】\n"
//          "【isDefaultAction】 : 是否默认选中  【bool】\n"
//          "【onPressed】 : 点击事件  【Function()】",
//    }

class CustomCupertinoAlertDialog extends StatelessWidget {
  const CustomCupertinoAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildRaisedButton(context),
        _buildCupertinoAlertDialog(context),
      ],
    );
  }

  Widget _buildRaisedButton(BuildContext context) =>
      ElevatedButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (ctx) => _buildCupertinoAlertDialog(context));
        },
        child: const Text(
          'Just Show It !',
          style:  TextStyle(color: Colors.white),
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
              child: const Text("Yes, Delete"),
              onPressed: () => Navigator.pop(context),
            ),
            CupertinoButton(
              child: const Text("Cancle"),
              onPressed: () => Navigator.pop(context),
            ),
          ]),
    );
  }

  Widget _buildTitle(context) {
    return Row(
        //标题
        children: <Widget>[
          const Icon(
            CupertinoIcons.delete_solid,
            color: Colors.red,
          ),
          const Expanded(
              child: Text(
            'Delete File',
            style:  TextStyle(color: Colors.red, fontSize: 20),
          )),
          InkWell(
            child: const Icon(CupertinoIcons.clear_thick),
            onTap: () => Navigator.pop(context),
          )
        ]);
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Column(
        children: const[
           Text(
            '    Hi toly! If you push the conform buttom ,'
            ' You will lose this file. Are you sure wand to do that?',
            style:  TextStyle(color: Color(0xff999999), fontSize: 16),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
