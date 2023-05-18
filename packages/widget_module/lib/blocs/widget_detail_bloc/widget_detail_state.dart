part of 'widget_detail_bloc.dart';

/// create by 张风捷特烈 on 2020-03-03
/// contact me by email 1981462002@qq.com
/// 说明: 详情状态类

abstract class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

class DetailWithData extends DetailState {
  final WidgetModel widgetModel;
  final List<WidgetModel> links;
  final List<NodeModel> nodes;

  const DetailWithData({
    required this.widgetModel,
    required this.nodes,
    required this.links,
  });

  @override
  List<Object> get props => [widgetModel, nodes];

  @override
  String toString() {
    return 'DetailWithData{widget: $widgetModel, nodes: $nodes}';
  }

  DetailWithData copyWith({
    WidgetModel? widgetModel,
    List<WidgetModel>? links,
    List<NodeModel>? nodes,
  }) {
    return DetailWithData(
      widgetModel: widgetModel ?? this.widgetModel,
      nodes: this.nodes,
      links: this.links,
    );
  }
}

class DetailLoading extends DetailState {}

class DetailEmpty extends DetailState {}

class DetailFailed extends DetailState {}
