
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/api/issues_api.dart';
import 'package:flutter_unit/blocs/point/point_state.dart';


import 'point_event.dart';


/// create by 张风捷特烈 on 2020-09-03
/// contact me by email 1981462002@qq.com
/// 说明:

class PointBloc extends Bloc<PointEvent, PointState> {

  @override
  PointState get initialState => PointLoading();

  @override
  Stream<PointState> mapEventToState(PointEvent event) async* {
    if (event is EventLoadPoint) {
      yield* _mapLoadWidgetToState();
    }
  }

  Stream<PointState> _mapLoadWidgetToState() async* {
    yield PointLoading();
    try {
      final issues = await IssuesApi.getIssues();
      yield PointLoaded(issues);
    } catch (err) {
      print(err);
      yield PointLoadFailure(err);
    }
  }
}
