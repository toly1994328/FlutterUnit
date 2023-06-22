import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


import 'package:intl/intl.dart';
import 'package:utils/utils.dart';

import 'package:storage/storage.dart';


/// create by 张风捷特烈 on 2020-04-21
/// contact me by email 1981462002@qq.com
/// 说明: 收藏夹展示数据模型

class CategoryModel extends Equatable {
  final int? id;
  final String name;
  final String info;
  final String? createDate;
  final String? imageCover;
  final int? count;
  final Color color;

  const CategoryModel(
      {required this.name,
      required this.id,
      required this.info,
      this.createDate,
      this.imageCover,
      this.count,
      required this.color});

  bool get canDelete => id != null && id! > 1;

  static CategoryModel fromPo(CategoryPo po) {
    return CategoryModel(
      id: po.id,
      name: po.name,
      info: po.info,
      createDate:po.created!=null? DateFormat('yyyy/MM/dd').format(po.created!):null,
      imageCover: po.image,
      count: po.count,
      color: ColorUtils.parse(po.color),
    );
  }

  @override
  List<Object?> get props => [
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


// 收藏集的 To 对象，用与上传/同步 收藏集
class CategoryTo{
  final CategoryPo model;
  final List<int> widgetIds;
  final List<dynamic>? likesData;

  CategoryTo({required this.model,required this.widgetIds, this.likesData});

  Map toJson() => {
    "model": model,
    "widgetIds": widgetIds,
    "likesData":likesData
  };
}