import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/enums.dart';
import 'package:flutter_unit/app/res/cons.dart';
import 'package:flutter_unit/repositories/itf/widget_repository.dart';

import 'home_event.dart';
import 'home_state.dart';

/// create by 张风捷特烈 on 2020-03-03
/// contact me by email 1981462002@qq.com
/// 说明:

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final WidgetRepository repository;

  HomeBloc({@required this.repository});

  @override
  HomeState get initialState => WidgetsLoading();

  Color get activeHomeColor {

    if (state is WidgetsLoaded) {
      return Color(Cons.tabColors[(state as WidgetsLoaded).activeFamily.index]);
    }
    return Color(Cons.tabColors[0]);
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is EventTabTap) {
      yield* _mapLoadWidgetToState(event.family);
    }
  }

  Stream<HomeState> _mapLoadWidgetToState(WidgetFamily family) async* {
    yield WidgetsLoading();
    try {
      final widgets = await this.repository.loadWidgets(family);
      yield WidgetsLoaded(widgets: widgets, activeFamily: family);
    } catch (err) {
      print(err);
      yield WidgetsLoadFailed();
    }
  }
}
