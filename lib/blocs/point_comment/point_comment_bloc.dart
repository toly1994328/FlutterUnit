
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/api/issues_api.dart';
import 'package:flutter_unit/blocs/point/point_state.dart';


import 'point_comment_event.dart';
import 'point_comment_state.dart';


/// create by 张风捷特烈 on 2020-09-03
/// contact me by email 1981462002@qq.com
/// 说明:

class PointCommentBloc extends Bloc<PointCommentEvent, PointCommentState> {

  @override
  PointCommentState get initialState => PointCommentInitial();

  @override
  Stream<PointCommentState> mapEventToState(PointCommentEvent event) async* {
    if (event is EventLoadPointComment) {
      yield* _mapLoadWidgetToState(event);
    }
  }

  Stream<PointCommentState> _mapLoadWidgetToState(EventLoadPointComment event) async* {
    yield PointCommentLoading(event.point);
    try {
      final comments = await IssuesApi.getIssuesComment(event.point.number);
      comments.sort((a,b)=>a.createdAt.compareTo(b.createdAt));
      yield PointCommentLoaded(event.point,comments);
    } catch (err) {
      print(err);
      yield PointCommentLoadFailure(err);
    }
  }
}
