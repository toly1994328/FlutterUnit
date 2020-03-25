import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/enums.dart';
import 'package:flutter_unit/repositorys/widget_repository.dart';

import 'widget_event.dart';
import 'widget_state.dart';

/// create by 张风捷特烈 on 2020-03-03
/// contact me by email 1981462002@qq.com
/// 说明:

class WidgetBloc extends Bloc<WidgetEvent, WidgetState> {
  final WidgetRepository repository;

  WidgetBloc({@required this.repository});

  @override
  // TODO: implement initialState
  WidgetState get initialState => WidgetsLoading();

  @override
  Stream<WidgetState> mapEventToState(WidgetEvent event) async* {
    if (event is LoadWidget) {
      yield* _mapLoadWidgetToState(event.family);
    }
  }

  Stream<WidgetState> _mapLoadWidgetToState(WidgetFamily family) async* {
    try {
      final widgets = await this.repository.loadWidgets(family);
      yield WidgetsLoaded(
        widgets,
      );
    } catch (_) {
      yield WidgetsLoadFailed();
    }
  }
}
