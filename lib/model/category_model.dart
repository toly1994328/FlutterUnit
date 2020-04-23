import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/app/utils/color_utils.dart';
import 'package:flutter_unit/storage/po/category_po.dart';
import 'package:intl/intl.dart';

/// create by 张风捷特烈 on 2020-04-21
/// contact me by email 1981462002@qq.com
/// 说明: 收藏夹展示数据模型

class CategoryModel extends Equatable{
  final int id;
  final String name;
  final String info;
  final String createDate;
  final String imageCover;
  final int count;
  final Color color;

  CategoryModel(
      {this.name,
        this.id,
        this.info,
        this.createDate,
        this.imageCover,
        this.count,
        this.color});

  bool get canDelete => id > 1;

  static CategoryModel fromPo(CategoryPo po) {
    return CategoryModel(
      id: po.id,
      name: po.name,
      info: po.info,
      createDate: DateFormat('yyyy-MM-dd HH:mm').format(po.created),
      imageCover: po.image,
      count: po.count,
      color: ColorUtils.parse(po.color),
    );
  }

  @override
  List<Object> get props => [
    id,
    name,
    info,
    createDate,
    imageCover,
    count,
    color,
  ];

  @override
  String toString() {
    return 'CategoryModel{id: $id, name: $name, info: $info, createDate: $createDate, imageCover: $imageCover, count: $count, color: $color}';
  }


}