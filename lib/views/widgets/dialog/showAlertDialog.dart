import 'package:flutter/material.dart';

showAlertDialog_(BuildContext context) {
  var title = Row(
    children: <Widget>[
      Image.asset("assets/images/icon_wwx.png", width: 30, height: 30,
      ),
      SizedBox(width: 10,),
      Text("表白")],
  );
  var content = Row(
    children: <Widget>[
      Text("我💖你，你是我的"),
      Image.asset("assets/images/icon_ylm.png", width: 30, height: 30,)
    ],
  );

  showDialog(
      context: context,
      builder: (context) =>//通过AlertDialog创建对话框内容
          AlertDialog(title: title, content: content, actions: <Widget>[
            FlatButton(
              child: Text("不要闹"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("走开"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ]));
}
