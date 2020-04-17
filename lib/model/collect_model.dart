import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-17
/// contact me by email 1981462002@qq.com
/// 说明: 收藏对象

class CollectModel {
  final String name;
  final String info;
  final String createDate;
  final String imageCover;
  final int count;
  final Color color;

  CollectModel(
      {this.name,
      this.info,
      this.createDate,
      this.imageCover,
      this.count,
      this.color});
}
