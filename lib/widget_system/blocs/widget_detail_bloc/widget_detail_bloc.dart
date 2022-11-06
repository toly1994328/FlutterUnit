import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_repository/widget_repository.dart';

import 'widget_detail_event.dart';
import 'widget_detail_state.dart';

/// create by 张风捷特烈 on 2020-03-03
/// contact me by email 1981462002@qq.com
/// 说明:

class WidgetDetailBloc extends Bloc<DetailEvent, DetailState> {

  final WidgetRepository repository;

  WidgetDetailBloc({required this.repository}) : super(DetailLoading()) {
    on<FetchWidgetDetail>(_onFetchWidgetDetail);
    on<ResetDetailState>(_onResetDetailState);
  }

  void _onFetchWidgetDetail(
      FetchWidgetDetail event, Emitter<DetailState> emit) async {
    emit(DetailLoading());
    try {
      final List<NodeModel> nodes =
          await repository.loadNode(event.widgetModel);
      final List<WidgetModel> links =
          await repository.loadWidget(event.widgetModel.links);
      if (nodes.isEmpty) {
        emit(DetailEmpty());
      } else {
        emit(DetailWithData(
            widgetModel: event.widgetModel, nodes: nodes, links: links));
      }
    } catch (_) {
      emit(DetailFailed());
    }
  }

  void _onResetDetailState(ResetDetailState event, Emitter<DetailState> emit) async{
    emit(DetailLoading());
  }
}
