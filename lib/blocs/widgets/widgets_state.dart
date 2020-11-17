import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/app/enums.dart';
import 'package:flutter_unit/model/widget_model.dart';

/// create by 张风捷特烈 on 2020-03-03
/// contact me by email 1981462002@qq.com
/// 说明: 主页状态类

abstract class WidgetsState extends Equatable {
  const WidgetsState();

  @override
  List<Object> get props => [];
}

class WidgetsLoading extends WidgetsState {
  const WidgetsLoading();

  @override
  List<Object> get props => [];
}

class WidgetsLoaded extends WidgetsState {
  final List<WidgetModel> widgets;
  final WidgetFamily activeFamily;

  const WidgetsLoaded(
      {this.activeFamily, this.widgets = const []});

  @override
  List<Object> get props => [activeFamily, widgets];

  @override
  String toString() {
    return 'WidgetsLoaded{widgets: $widgets}';
  }
}

class WidgetsLoadFailed extends WidgetsState {
  final String error;


  const WidgetsLoadFailed(this.error);

  @override
  List<Object> get props => [error];
}
