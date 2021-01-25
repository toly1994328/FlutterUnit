
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/repositories/itf/widget_repository.dart';

import 'like_event.dart';
import 'like_state.dart';

/// create by 张风捷特烈 on 2020-04-07
/// contact me by email 1981462002@qq.com
/// 说明:

class LikeWidgetBloc extends Bloc<LikeWidgetEvent, LikeWidgetState> {
  final WidgetRepository repository;

  LikeWidgetBloc({@required this.repository}):super(LikeWidgetState(widgets: []));


  @override
  Stream<LikeWidgetState> mapEventToState(
    LikeWidgetEvent event,
  ) async* {
    if (event is ToggleLikeWidgetEvent) {
      await repository.toggleCollect(event.id);
      final widgets = await repository.loadCollectWidgets();
      yield LikeWidgetState(widgets: widgets);
    }
    if( event is EventSetCollectData){
      final widgets = await repository.loadCollectWidgets();
      yield LikeWidgetState(widgets: widgets);
    }
  }
}
