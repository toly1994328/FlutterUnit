part of 'widgets_bloc.dart';

/// create by 张风捷特烈 on 2020-03-03
/// contact me by email 1981462002@qq.com
/// 说明: 主页 Widget 列表 状态类

/// 对于一个可查询、可分页的数据集
/// 状态类持有过滤数据 Filter, 任何衍生状态都需要感知过滤的信息，比如加载异常，点击重试，可以基于最后的过滤状态。
/// 分页加载 信息需要 了解 总数据、页数、每页含量
abstract class WidgetsState extends Equatable {
  final WidgetFilter filter;
  final LoadOperate operate;
  const WidgetsState({required this.filter, required this.operate});

  @override
  List<Object> get props => [filter];
}

class WidgetsLoading extends WidgetsState {
  const WidgetsLoading(
      {super.filter = const WidgetFilter(), super.operate = LoadOperate.load});
}

/// [full] 是否已满，用于加载更多到底的标识
/// [widgets] 加载的数据
class WidgetsLoaded extends WidgetsState {
  final List<WidgetModel> widgets;
  final bool full;
  final int fetchTime;

  const WidgetsLoaded({
    this.widgets = const [],
    required super.filter,
    required super.operate,
    this.full = false,
    this.fetchTime = 0,
  });

  @override
  List<Object> get props => [widgets,full,filter,operate,fetchTime];

  @override
  String toString() {
    return 'WidgetsLoaded{widgets: $widgets}';
  }

  WidgetsLoaded copyWith({
    List<WidgetModel>? widgets,
    bool? full,
    LoadOperate? operate,
    WidgetFilter? filter,
    int? fetchTime,
}){
    return WidgetsLoaded(
        widgets:widgets??this.widgets,
      full:full??this.full,
      operate:operate??this.operate,
      filter:filter??this.filter,
      fetchTime:fetchTime??this.fetchTime,
    );
  }

}

class WidgetsLoadFailed extends WidgetsState {
  final String error;

  const WidgetsLoadFailed(this.error,
      {required super.filter, required super.operate});

  @override
  List<Object> get props => [error];
}

/// 加载类型
/// [load] 加载第一页数据, 用于首次加载，
/// [refresh] 下拉刷新状态标识。之前加载的更多数据将会被移除
/// [more] 加载更多状态标识。
///
enum LoadOperate {
  load,
  refresh,
  more,
}
