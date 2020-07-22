import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/model/widget_model.dart';
import 'package:flutter_unit/repositories/itf/widget_repository.dart';

import 'detail_event.dart';
import 'detail_state.dart';

/// create by 张风捷特烈 on 2020-03-03
/// contact me by email 1981462002@qq.com
/// 说明:

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final WidgetRepository repository;

  DetailBloc({@required this.repository});

  @override
  DetailState get initialState => DetailLoading();

  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    if (event is FetchWidgetDetail) {
      yield* _mapLoadWidgetToState(event.widgetModel);
    }
    if(event is ResetDetailState){
      yield DetailLoading();
    }
  }

  Stream<DetailState> _mapLoadWidgetToState(
      WidgetModel widgetModel) async* {
    yield DetailLoading();
    try {
      final nodes = await this.repository.loadNode(widgetModel);
      final links = await this.repository.loadWidget(widgetModel.links);
      if(nodes.isEmpty){
        yield DetailEmpty();
      }else{
        yield DetailWithData(widgetModel: widgetModel, nodes: nodes,links: links);
      }

    } catch (_) {
      yield DetailFailed();
    }
  }
}
