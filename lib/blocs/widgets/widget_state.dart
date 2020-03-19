import 'package:equatable/equatable.dart';
import 'package:flutter_unit/model/widget_model.dart';


/// create by 张风捷特烈 on 2020-03-03
/// contact me by email 1981462002@qq.com
/// 说明: widget状态类

abstract class WidgetState extends Equatable {
  const WidgetState();
  @override
  List<Object> get props => [];
}

class WidgetsLoading extends WidgetState {}

class WidgetsLoaded extends WidgetState {
  final List<WidgetModel> widgets;

  const WidgetsLoaded([this.widgets = const []]);

  @override
  List<Object> get props => [widgets];

  @override
  String toString() {
    return 'WidgetsLoaded{widgets: $widgets}';
  }


}

class WidgetsLoadFailed extends WidgetState {}
