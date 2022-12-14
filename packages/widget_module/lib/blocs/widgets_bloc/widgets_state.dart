part of 'widgets_bloc.dart';

/// create by 张风捷特烈 on 2020-03-03
/// contact me by email 1981462002@qq.com
/// 说明: 主页 Widget 列表 状态类

abstract class WidgetsState extends Equatable {
  final WidgetFilter filter;
  const WidgetsState({required this.filter});

  @override
  List<Object> get props => [];
}

class WidgetsLoading extends WidgetsState {
  const WidgetsLoading({ WidgetFilter filter=const WidgetFilter()}) : super(filter:filter) ;
}

class WidgetsLoaded extends WidgetsState {
  final List<WidgetModel> widgets;

  const WidgetsLoaded( {this.widgets = const [],required WidgetFilter filter}): super(filter:filter);

  @override
  List<Object> get props => [widgets];

  @override
  String toString() {
    return 'WidgetsLoaded{widgets: $widgets}';
  }
}

class WidgetsLoadFailed extends WidgetsState {
  final String error;

  const WidgetsLoadFailed(this.error,
      {required WidgetFilter filter}): super(filter:filter);

  @override
  List<Object> get props => [error];
}
