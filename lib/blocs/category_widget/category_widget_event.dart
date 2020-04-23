import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-21
/// contact me by email 1981462002@qq.com
/// 说明: 

abstract class CategoryWidgetEvent extends Equatable{
  @override
  List<Object> get props => [];
}

//class EventLoadCategory extends CategoryWidgetEvent{
//  @override
//  List<Object> get props => [];
//}

class EventLoadCategoryWidget extends CategoryWidgetEvent{
  final int categoryId;

  EventLoadCategoryWidget(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

class EventToggleCategoryWidget extends CategoryWidgetEvent{
  final int categoryId;
  final int widgetId;

  EventToggleCategoryWidget(this.categoryId,this.widgetId);

  @override
  List<Object> get props => [categoryId,widgetId];
}

//class EventDeleteCategory extends CategoryWidgetEvent{
//  final int id;
//
//  EventDeleteCategory({@required this.id});
//
//  @override
//  List<Object> get props => [id];
//}
//
//class EventAddCategory extends CategoryWidgetEvent{
//  final String name;
//  final String info;
//  final String color;
//
//  EventAddCategory({@required this.name, this.info, this.color});
//
//  @override
//  List<Object> get props => [name,info,color];
//}
