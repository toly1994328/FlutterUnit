import 'package:equatable/equatable.dart';
import 'package:flutter_unit/model/widget_model.dart';

/// create by 张风捷特烈 on 2020-04-09
/// contact me by email 1981462002@qq.com
/// 说明: 

class CollectState extends Equatable {
  final List<WidgetModel> widgets;

  CollectState({this.widgets});

  @override
  // TODO: implement props
  List<Object> get props => [widgets];
}
