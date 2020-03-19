import 'package:equatable/equatable.dart';
import 'package:flutter_unit/database/po/widget_po.dart';
import 'package:flutter_unit/model/widget_model.dart';


/// create by 张风捷特烈 on 2020-03-03
/// contact me by email 1981462002@qq.com
/// 说明: 

abstract class WidgetEvent extends Equatable {
  const WidgetEvent();
  @override
  List<Object> get props => [];
}

class LoadWidget extends WidgetEvent {}

class SeeWidgetDetail extends WidgetEvent {
  final WidgetModel widgetModel;
  const SeeWidgetDetail(this.widgetModel);

  @override
  List<Object> get props => [widgetModel];

  @override
  String toString() {
    return 'SeeWidgetDetail{widgetModel: $widgetModel}';
  }
}

class AddWidget extends WidgetEvent {
  final WidgetPo widgetModel;
  const AddWidget(this.widgetModel);

  @override
  List<Object> get props => [widgetModel];

  @override
  String toString() {
    return 'AddWidget{widgetModel: $widgetModel}';
  }
}