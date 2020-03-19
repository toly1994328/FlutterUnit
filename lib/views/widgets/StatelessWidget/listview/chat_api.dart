import 'dart:math';

import 'package:flutter/material.dart';

import 'chart_widget.dart';


class ChatApi{
  var random = Random();//随机数
  List<ChatItem> _chatItem=<ChatItem>[];
  List<ChatItem> get chatItem=>_chatItem;

  ChatApi.monk(int count){
    var strs = ["我是要成为编程之王的男人，"
        "你是要成为编程之王的女人；","Hello World",
      "凭君莫话封侯事，一将功成万骨枯。你觉得如何?",
      "识君，吾之幸也;失君，吾之憾也;守君，吾之愿也。",
      "简单必有简单的成本，复杂必有复杂的价值。"];

    for (var i = 0; i < count; i++) {
      _chatItem.add(ChatItem(
          headIcon: AssetImage(i.isEven ?
          "assets/images/wy_200x300.jpg" :
          "assets/images/icon_head.png"),
          text: strs[random.nextInt(strs.length)],
          type: i.isEven ?
          ChartType.left : ChartType.right));
    }
  }

  Future<void> addTop() async{
    //模拟耗时
    await Future.delayed(Duration(seconds: 3));
    _chatItem.insert(0,ChatItem(
        headIcon: AssetImage("assets/images/wy_200x300.jpg"),
        type: ChartType.left,
        text: "我是下拉出来的"));
  }

  Future<void> addBottom() async{
    //模拟耗时
    await Future.delayed(Duration(seconds: 3));
    _chatItem.add(ChatItem(
        headIcon: AssetImage("assets/images/icon_head.png"),
        type: ChartType.right,
        text: "我是上拉出来的"),
    );
  }
}