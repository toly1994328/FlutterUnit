import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/widget_system/repositories/repositories.dart';


import 'liked_widget_event.dart';
import 'liked_widget_state.dart';

/// create by 张风捷特烈 on 2020-04-07
/// contact me by email 1981462002@qq.com
/// 说明:

class LikeWidgetBloc extends Bloc<LikeWidgetEvent, LikeWidgetState> {
  final WidgetRepository repository;

  LikeWidgetBloc({required this.repository}):super(LikeWidgetState(widgets: [])){
   on<EventLoadLikeData>(_onEventLoadLikeData) ;
   on<ToggleLikeWidgetEvent>(_onToggleLikeWidgetEvent) ;
  }

  void _onEventLoadLikeData(EventLoadLikeData event, Emitter<LikeWidgetState> emit) async{
    final widgets = await repository.loadLikeWidgets();
    emit(LikeWidgetState(widgets: widgets));
  }

  void _onToggleLikeWidgetEvent(ToggleLikeWidgetEvent event, Emitter<LikeWidgetState> emit) async{
    await repository.toggleLike(event.id);
    final widgets = await repository.loadLikeWidgets();
    emit(LikeWidgetState(widgets: widgets));
  }
}
