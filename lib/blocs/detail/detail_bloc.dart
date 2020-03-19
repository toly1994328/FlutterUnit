import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/model/widget_model.dart';
import 'package:flutter_unit/repositorys/widget_repository.dart';

import 'detail_event.dart';
import 'detail_state.dart';

/// create by 张风捷特烈 on 2020-03-03
/// contact me by email 1981462002@qq.com
/// 说明:

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final WidgetRepository repository;

  DetailBloc({@required this.repository});

  @override
  DetailState get initialState => DetailEmpty();

  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    if (event is ToWidgetDetail) {
      yield* _mapLoadWidgetToState(event.widgetModel);
    }
  }

  Stream<DetailState> _mapLoadWidgetToState(
      WidgetModel widgetModel) async* {
    try {
      final nodes = await this.repository.loadNode(widgetModel);
      yield DetailWithData(
          widgetModel: widgetModel, nodes: nodes);
    } catch (_) {
      yield DetailFailed();
    }
  }
}
