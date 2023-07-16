part of 'widgets_bloc.dart';

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

  const EventTabTap(this.family);

  @override
  List<Object> get props => [family];
}

class EventLoadMore extends WidgetsEvent {

  @override
  List<Object> get props => [];
}

class EventRefresh extends WidgetsEvent {

  @override
  List<Object> get props => [];
}


class EventSearchWidget extends WidgetsEvent {
  final WidgetFilter filter;//参数
  const EventSearchWidget({required this.filter});
}

