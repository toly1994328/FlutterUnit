import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-21
/// contact me by email 1981462002@qq.com
/// 说明: 

abstract class CategoryEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class EventLoadCategory extends CategoryEvent{
  @override
  List<Object> get props => [];
}

class EventToggleWidget extends CategoryEvent{
  final int widgetId;
  final int categoryId;
  EventToggleWidget({this.widgetId, this.categoryId});

  @override
  List<Object> get props => [widgetId,categoryId];
}

class EventDeleteCategory extends CategoryEvent{
  final int id;

  EventDeleteCategory({@required this.id});

  @override
  List<Object> get props => [id];
}

class EventAddCategory extends CategoryEvent{
  final String name;
  final String info;
  final String color;

  EventAddCategory({@required this.name, this.info, this.color});

  @override
  List<Object> get props => [name,info,color];
}

class EventUpdateCategory extends CategoryEvent {
  final int id;
  final String name;
  final String info;
  final String color;
  final int  priority;
  final String image;

  EventUpdateCategory({@required this.name, this.info, this.color,this.priority,this.image,this.id});

  @override
  List<Object> get props => [name, info, color,priority,image,id];
}
