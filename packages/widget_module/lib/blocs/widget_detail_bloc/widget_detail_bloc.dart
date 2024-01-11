import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/exp.dart';

part 'widget_detail_state.dart';

/// create by 张风捷特烈 on 2020-03-03
/// contact me by email 1981462002@qq.com
/// 说明: 组件详情页状态数据维护核心类
/// [_modelStack] 组件详情页支持管理跳转,栈数据交由 Bloc 维护

class WidgetDetailBloc extends Cubit<DetailState> {
  final WidgetRepository widgetRepository;
  final NodeRepository nodeRepository;

  WidgetDetailBloc({
    required this.widgetRepository,
    required this.nodeRepository,
  }) : super(DetailLoading());

  final List<WidgetModel> _modelStack = [];

  WidgetModel get currentWidget => _modelStack.last;

  void push(WidgetModel model){
    _modelStack.add(model);
    queryDetail(model);
  }

  Future<bool> pop() async{
    if(_modelStack.isEmpty){
      return true;
    }
    _modelStack.removeLast();
    if (_modelStack.isNotEmpty) {
      queryDetail(currentWidget);
      return false;
    } else {
      return true;
    }
  }

  void queryDetail(WidgetModel widget) async {
    emit(DetailLoading());
    try {
      final List<NodeModel> nodes = await nodeRepository.loadNode(widget.id);
      final List<WidgetModel> links = await widgetRepository.loadWidget(widget.links);
      if (nodes.isEmpty) {
        emit(DetailEmpty());
      } else {
        emit(DetailWithData(
          widgetModel: widget,
          nodes: nodes,
          links: links,
        ));
      }
    } catch (_) {
      emit(DetailFailed());
    }
  }
}
