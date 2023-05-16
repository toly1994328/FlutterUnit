
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_repository/widget_repository.dart';

part 'widgets_event.dart';
part 'widgets_state.dart';

/// create by 张风捷特烈 on 2020-03-03
/// contact me by email 1981462002@qq.com
/// 说明: 处理主页 Widget 列表加载逻辑

class WidgetsBloc extends Bloc<WidgetsEvent, WidgetsState> {
  final WidgetRepository repository;

  WidgetsBloc({required this.repository}):super(const WidgetsLoading()){
    on<EventTabTap>(_onEventTabTap);
    on<EventSearchWidget>(_onEventSearchWidget);
  }

  void _onEventTabTap(EventTabTap event, Emitter<WidgetsState> emit) async{
    emit( const WidgetsLoading());
    WidgetFilter filter = WidgetFilter.family(event.family);
    try {
      final List<WidgetModel> widgets = await repository.searchWidgets(
          filter
      );
      emit( WidgetsLoaded(widgets: widgets,filter: filter));
    } catch (err) {
      print(err);
      emit(WidgetsLoadFailed(err.toString(),filter: filter));
    }
  }

  void _onEventSearchWidget(EventSearchWidget event, Emitter<WidgetsState> emit) async{
    emit( const WidgetsLoading());
    try {
      final List<WidgetModel> widgets = await repository.searchWidgets(
          event.filter
      );
      emit( WidgetsLoaded(widgets: widgets,filter:  event.filter));
    } catch (err) {
      print(err);
      emit(WidgetsLoadFailed(err.toString(),filter:  event.filter));
    }
  }
}
