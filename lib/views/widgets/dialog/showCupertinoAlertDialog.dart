import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showCupertinoAlertDialog_(BuildContext context) {
  var title = Row(
    children: <Widget>[
      Image.asset("images/icon_wwx.png", width: 30, height: 30,
      ),
      SizedBox(width: 10,),
      Text("表白")],
  );
  var content = Row(
    children: <Widget>[
      Text("我💖你，你是我的"),
      Image.asset("images/icon_ylm.png", width: 30, height: 30,)
    ],
  );

  showDialog(context: context, builder: (context)=>CupertinoAlertDialog(
    content: content,
    title: title,
    actions: <Widget>[
      CupertinoButton(
        child: Text("不要闹"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      CupertinoButton(
        child: Text("走开"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ],
  ));
}
