
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/point_system/api/issues_api.dart';
import 'package:flutter_unit/point_system/github_model/github_model.dart';



import 'point_comment_event.dart';
import 'point_comment_state.dart';


/// create by 张风捷特烈 on 2020-09-03
/// contact me by email 1981462002@qq.com
/// 说明:

class PointCommentBloc extends Bloc<PointCommentEvent, PointCommentState> {

  PointCommentBloc() : super(PointCommentInitial());



  @override
  Stream<PointCommentState> mapEventToState(PointCommentEvent event) async* {
    if (event is EventLoadPointComment) {
      yield* _mapLoadWidgetToState(event);
    }
  }

  Stream<PointCommentState> _mapLoadWidgetToState(EventLoadPointComment event) async* {
    yield PointCommentLoading(event.point);
    if(event.point.number==null){
      yield PointCommentLoadFailure('point_bloc id 为空');
    }
    try {
      final List<IssueComment> comments = await IssuesApi.getIssuesComment(event.point.number!);
      comments.sort((a,b)=>a.createdAt!.compareTo(b.createdAt!));
      yield PointCommentLoaded(event.point,comments);
    } catch (err) {
      print(err);
      yield PointCommentLoadFailure(err.toString());
    }
  }
}
