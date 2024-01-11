

import 'package:equatable/equatable.dart';
import '../../data/model/issue.dart';

/// create by 张风捷特烈 on 2020/9/3
/// contact me by email 1981462002@qq.com
/// 说明:

abstract class PointCommentEvent extends Equatable {}

class EventLoadPointComment extends PointCommentEvent {
  final Issue point;

  EventLoadPointComment(this.point);

  @override
  List<Object> get props => [point];
}
