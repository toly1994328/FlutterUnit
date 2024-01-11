
import 'package:flutter_bloc/flutter_bloc.dart';



import '../../data/api/issues_api.dart';
import '../../data/model/github_model.dart';
import 'point_comment_event.dart';
import 'point_comment_state.dart';


/// create by 张风捷特烈 on 2020-09-03
/// contact me by email 1981462002@qq.com
/// 说明:

class PointCommentBloc extends Bloc<PointCommentEvent, PointCommentState> {

  PointCommentBloc() : super(PointCommentInitial()){
    on<EventLoadPointComment>(_onEventLoadPointComment);
  }

  void _onEventLoadPointComment(EventLoadPointComment event,Emitter<PointCommentState> emit) async{
    emit( PointCommentLoading(event.point));
    if(event.point.number==null){
      emit( PointCommentLoadFailure('point_bloc id 为空'));
    }
    try {
      final List<IssueComment> comments = await IssuesApi.getIssuesComment(event.point.number!);
      comments.sort((a,b)=>a.createdAt!.compareTo(b.createdAt!));
      emit( PointCommentLoaded(event.point,comments));
    } catch (err) {
      print(err);
      emit( PointCommentLoadFailure(err.toString()));
    }
  }
}
