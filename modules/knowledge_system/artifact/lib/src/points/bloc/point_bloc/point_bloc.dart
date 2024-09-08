
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/api/issues_api.dart';
import 'point_event.dart';
import 'point_state.dart';


/// create by 张风捷特烈 on 2020-09-03
/// contact me by email 1981462002@qq.com
/// 说明:

class PointBloc extends Bloc<PointEvent, PointState> {
  PointBloc() : super(PointLoading()){
    on<EventLoadPoint>(_onEventLoadPoint);
  }

  void _onEventLoadPoint(PointEvent event,Emitter<PointState> emit) async{
    emit( PointLoading());
    try {
      final issues = await IssuesApi.getIssues();
      emit( PointLoaded(issues));
    } catch (err) {
      print(err);
      emit( PointLoadFailure(err.toString()));
    }
  }
}
