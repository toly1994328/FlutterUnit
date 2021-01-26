import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/model/enums.dart';
import 'package:flutter_unit/repositories/itf/widget_repository.dart';

import 'widgets_event.dart';
import 'widgets_state.dart';

/// create by 张风捷特烈 on 2020-03-03
/// contact me by email 1981462002@qq.com
/// 说明: 处理主页 Widget 列表加载逻辑

class WidgetsBloc extends Bloc<WidgetsEvent, WidgetsState> {
  final WidgetRepository repository;

  WidgetsBloc({@required this.repository}):super(WidgetsLoading(WidgetFamily.statelessWidget));



  @override
  Stream<WidgetsState> mapEventToState(WidgetsEvent event) async* {
    if (event is EventTabTap) {
      yield* _mapLoadWidgetToState(event.family);
    }
  }

  Stream<WidgetsState> _mapLoadWidgetToState(WidgetFamily family) async* {
    yield WidgetsLoading(family);
    try {
      final widgets = await this.repository.loadWidgets(family);
      yield WidgetsLoaded(family, widgets: widgets);
    } catch (err) {
      print(err);
      yield WidgetsLoadFailed(family,err.toString());
    }
  }
}
