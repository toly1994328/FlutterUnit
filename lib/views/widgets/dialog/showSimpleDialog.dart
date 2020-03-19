import 'package:flutter/material.dart';

showSimpleDialog_(BuildContext context) {
  var strs = [
    "泽国江山入战图，生民何计乐樵苏。",
    "凭君莫话封侯事，一将功成万骨枯。",
    "传闻一战百神愁，两岸强兵过未休。",
    "谁道沧江总无事，近来长共血争流。"];

  var title = Row(
    //标题
    children: <Widget>[
      Image.asset("assets/images/icon_lwj.png", width: 30, height: 30,),
      SizedBox(width: 10,),
      Text("己亥岁二首·曹松")],);

  showDialog(//内置方法，创建对话弹框
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: title,
          children: strs.map((str) {
            return SimpleDialogOption(
              child: Row(
                children: <Widget>[
                  Icon(Icons.turned_in_not, color: Colors.blue,),
                  Text(str)],),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          }).toList(),
        );
      });
}