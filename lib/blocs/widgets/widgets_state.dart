import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/model/enums.dart';
import 'package:flutter_unit/app/res/cons.dart';
import 'package:flutter_unit/model/widget_model.dart';

/// create by 张风捷特烈 on 2020-03-03
/// contact me by email 1981462002@qq.com
/// 说明: 主页 Widget 列表 状态类

abstract class WidgetsState extends Equatable {
  final WidgetFamily activeFamily;

  const WidgetsState(this.activeFamily);

  Color get color => Color(Cons.tabColors[activeFamily.index]);
  Color get nextColor => Color(Cons.tabColors[(activeFamily.index+1)%Cons.tabColors.length]);

  @override
  List<Object> get props => [activeFamily];
}

class WidgetsLoading extends WidgetsState {
  WidgetsLoading(WidgetFamily activeFamily) : super(activeFamily);

  @override
  List<Object> get props => [activeFamily];
}

class WidgetsLoaded extends WidgetsState {
  final List<WidgetModel> widgets;

  WidgetsLoaded(WidgetFamily activeFamily, {this.widgets = const []})
      : super(activeFamily);

  @override
  List<Object> get props => [activeFamily,widgets];

  @override
  String toString() {
    return 'WidgetsLoaded{widgets: $widgets}';
  }
}

class WidgetsLoadFailed extends WidgetsState {
  final String error;

  const WidgetsLoadFailed(WidgetFamily activeFamily, this.error)
      : super(activeFamily);

  @override
  List<Object> get props => [activeFamily,error];
}
