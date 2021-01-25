import 'package:equatable/equatable.dart';
import 'package:flutter_unit/model/enums.dart';


/// create by 张风捷特烈 on 2020-03-03
/// contact me by email 1981462002@qq.com
/// 说明: 

abstract class WidgetsEvent extends Equatable {
  const WidgetsEvent();
  @override
  List<Object> get props => [];
}

class EventTabTap extends WidgetsEvent {
  final WidgetFamily family;

  EventTabTap(this.family);

}


