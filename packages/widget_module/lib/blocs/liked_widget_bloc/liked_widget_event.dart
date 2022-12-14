part of 'liked_widget_bloc.dart';

/// create by 张风捷特烈 on 2020-04-09
/// contact me by email 1981462002@qq.com
/// 说明:

abstract class LikeWidgetEvent extends Equatable {
  const LikeWidgetEvent();
}

class EventLoadLikeData extends LikeWidgetEvent {
  const EventLoadLikeData();

  @override
  List<Object> get props => [];
}

class ToggleLikeWidgetEvent extends LikeWidgetEvent {
  final int id;

  const  ToggleLikeWidgetEvent({required this.id});

  @override
  // TODO: implement props
  List<Object> get props => [id];
}

class LoadCollectEvent extends LikeWidgetEvent {
  const LoadCollectEvent();

  @override
  List<Object> get props => [];
}
