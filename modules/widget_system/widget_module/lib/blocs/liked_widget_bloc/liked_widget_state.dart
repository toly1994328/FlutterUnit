part of 'liked_widget_bloc.dart';

/// create by 张风捷特烈 on 2020-04-09
/// contact me by email 1981462002@qq.com
/// 说明: 

class LikeWidgetState extends Equatable {
  final List<WidgetModel> widgets;

  const LikeWidgetState({required this.widgets});

  @override
  List<Object> get props => [widgets];
}
