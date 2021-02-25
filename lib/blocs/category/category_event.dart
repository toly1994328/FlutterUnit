import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-21
/// contact me by email 1981462002@qq.com
/// 说明:  收藏集相关事件

abstract class CategoryEvent extends Equatable{
  const CategoryEvent();
  @override
  List<Object> get props => [];
}
// 加载 收藏集 事件
class EventLoadCategory extends CategoryEvent{
  const EventLoadCategory();
  @override
  List<Object> get props => [];
}

// 将一个 widget 添加/移除 收藏集
class EventToggleWidget extends CategoryEvent{
  final int widgetId;
  final int categoryId;
  const EventToggleWidget({this.widgetId, this.categoryId});

  @override
  List<Object> get props => [widgetId,categoryId];
}

// 删除 收藏集
class EventDeleteCategory extends CategoryEvent{
  final int id;

  const EventDeleteCategory({@required this.id});

  @override
  List<Object> get props => [id];
}

// 添加 收藏集
class EventAddCategory extends CategoryEvent{
  final String name;
  final String info;
  final String color;

  const EventAddCategory({@required this.name, this.info, this.color});

  @override
  List<Object> get props => [name,info,color];
}

// 更新 收藏集
class EventUpdateCategory extends CategoryEvent {
  final int id;
  final String name;
  final String info;
  final String color;
  final int  priority;
  final String image;

  const EventUpdateCategory({@required this.name, this.info, this.color,this.priority,this.image,this.id});

  @override
  List<Object> get props => [name, info, color,priority,image,id];
}