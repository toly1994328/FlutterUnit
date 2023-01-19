import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 131,
//      "name": 'CupertinoActionSheet基本使用',
//      "priority": 1,
//      "subtitle": "【title】 : 第一行组件   【Widget】\n"
//          "【message】 : 第二行组件  【Widget】\n"
//          "【cancelButton】 : 取消按钮处组件  【Widget】\n"
//          "【actions】 : 中间组件列表  【List<Widget>】",
//    }
class CustomCupertinoActionSheet extends StatelessWidget {
  const CustomCupertinoActionSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildRaisedButton(context),
        _buildCupertinoActionSheet(context),
      ],
    );
  }

  Widget _buildCupertinoActionSheet(BuildContext context) =>
      Container(
        alignment: Alignment.bottomCenter,
        child: CupertinoActionSheet(
          title: const Text("Please chose a language"),
          message: const Text('the language you use in this application.'),
          cancelButton: CupertinoActionSheetAction(
              onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          actions: <Widget>[
            CupertinoActionSheetAction(
                onPressed: () => Navigator.pop(context),
                child: const Text('Dart')),
            CupertinoActionSheetAction(
                onPressed: () => Navigator.pop(context),
                child: const Text('Java')),
            CupertinoActionSheetAction(
                onPressed: () => Navigator.pop(context),
                child: const Text('Kotlin')),
          ],
        ),
      );

  Widget _buildRaisedButton(BuildContext context) => ElevatedButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        onPressed: () => showDialog(
            context: context,
            builder: (ctx) => _buildCupertinoActionSheet(context)),
        child: const Text(
          'Just Show It !',
          style: TextStyle(color: Colors.white),
        ),
      );
}
