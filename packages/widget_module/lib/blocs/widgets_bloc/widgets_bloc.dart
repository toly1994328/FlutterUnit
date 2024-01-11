import 'dart:async';
import 'dart:io';

import 'package:app/app.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/exp.dart';

part 'widgets_event.dart';

part 'widgets_state.dart';

/// create by 张风捷特烈 on 2020-03-03
/// contact me by email 1981462002@qq.com
/// 说明: 处理主页 Widget 列表加载逻辑

class WidgetsBloc extends Bloc<WidgetsEvent, WidgetsState> {
  final WidgetRepository repository;

  WidgetsBloc({required this.repository}) : super(const WidgetsLoading()) {
    on<EventTabTap>(_onEventTabTap);
    on<EventLoadMore>(_onEventLoadMore);
    on<EventRefresh>(_onEventRefresh);
    on<EventSearchWidget>(_onEventSearchWidget);
  }

  /// 切换页签，以 [family] 为过滤项
  void _onEventTabTap(EventTabTap event, Emitter<WidgetsState> emit) async {
    emit(const WidgetsLoading(operate: LoadOperate.load));
    int size = isDesk?1000:20;
    WidgetFilter filter = WidgetFilter.family(event.family,pageSize: size);
    try {
      final List<WidgetModel> widgets = await repository.searchWidgets(filter);
      emit(WidgetsLoaded(
        widgets: widgets,
        filter: filter,
        operate: LoadOperate.load,
      ));
    } catch (err) {
      print(err);
      emit(WidgetsLoadFailed(
        err.toString(),
        filter: filter,
        operate: LoadOperate.load,
      ));
    }
  }

  FutureOr<void> _onEventRefresh(
      EventRefresh event, Emitter<WidgetsState> emit) async {
    // emit(const WidgetsLoading(operate: LoadOperate.refresh));
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final List<WidgetModel> widgets =
      await repository.searchWidgets(state.filter.copyWith(
        page: 1,
      ));
      emit(WidgetsLoaded(
          widgets: widgets,
          filter: state.filter,
          operate: LoadOperate.refresh,
          fetchTime: DateTime.now().millisecondsSinceEpoch));
    } catch (err) {
      print(err);
      emit(WidgetsLoadFailed(
        err.toString(),
        filter: state.filter,
        operate: LoadOperate.refresh,
      ));
    }
  }

  FutureOr<void> _onEventLoadMore(
      EventLoadMore event, Emitter<WidgetsState> emit) async {
    if (state is WidgetsLoaded) {
      WidgetsLoaded old = (state as WidgetsLoaded);
      int total = await repository.total(old.filter);
      if (old.widgets.length < old.filter.pageSize) {
        // 不满一页
        emit(old.copyWith(full: true,
          operate: LoadOperate.more,
          fetchTime: DateTime.now().millisecondsSinceEpoch,));
        return;
      }

      if (total <= old.widgets.length) {
        // 已满
        emit(old.copyWith(full: true,
          operate: LoadOperate.more,
          fetchTime: DateTime.now().millisecondsSinceEpoch,));
        return;
      }
      // 未满，继续加载下一页
      int pageIndex = old.widgets.length ~/ old.filter.pageSize + 1;
      WidgetFilter filter = old.filter.copyWith(page: pageIndex);
      final List<WidgetModel> newData = await repository.searchWidgets(filter);
      List<WidgetModel> newWidget = old.widgets + newData;
      emit(old.copyWith(
          widgets: newWidget,
          full: newWidget.length == total,
          operate: LoadOperate.more,
          fetchTime: DateTime.now().millisecondsSinceEpoch,
          filter: filter));
    }
  }

  void _onEventSearchWidget(
      EventSearchWidget event, Emitter<WidgetsState> emit) async {
    emit(const WidgetsLoading(operate: LoadOperate.load));
    try {
      final List<WidgetModel> widgets =
          await repository.searchWidgets(event.filter);
      emit(WidgetsLoaded(
          widgets: widgets, filter: event.filter, operate: LoadOperate.load));
    } catch (err) {
      print(err);
      emit(WidgetsLoadFailed(err.toString(),
          filter: event.filter, operate: LoadOperate.load));
    }
  }
}
