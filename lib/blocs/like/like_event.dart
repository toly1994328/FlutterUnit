import 'package:equatable/equatable.dart';

/// create by 张风捷特烈 on 2020-04-09
/// contact me by email 1981462002@qq.com
/// 说明:

abstract class LikeWidgetEvent extends Equatable {}

class EventLoadLikeData extends LikeWidgetEvent {
  List<Object> get props => [];
}

class ToggleLikeWidgetEvent extends LikeWidgetEvent {
  final int id;

  ToggleLikeWidgetEvent({this.id});

  @override
  // TODO: implement props
  List<Object> get props => [id];
}

class LoadCollectEvent extends LikeWidgetEvent {
  @override
  List<Object> get props => [];
}
