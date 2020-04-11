import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/database/widget_dao.dart';
import 'package:flutter_unit/repositorys/widget_repository.dart';

import 'collect_event.dart';
import 'collect_state.dart';

/// create by 张风捷特烈 on 2020-04-07
/// contact me by email 1981462002@qq.com
/// 说明:



class CollectBloc extends Bloc<CollectEvent, CollectState> {
  final WidgetRepository repository;

  CollectBloc({@required this.repository});

  @override
  CollectState get initialState => CollectState(collect: false,widgets: []); //初始状态

  @override
  Stream<CollectState> mapEventToState(
    CollectEvent event,
  ) async* {
    if (event is ToggleCollectEvent) {
      await repository.toggleCollect(event.id);
      final widgets = await repository.loadCollectWidgets();
      yield CollectState(collect: !state.collect,widgets: widgets);
    }
    if( event is EventSetCollectData){
      final widgets = await repository.loadCollectWidgets();
      yield CollectState(collect: state.collect,widgets: widgets);
    }
  }
}
