import 'package:equatable/equatable.dart';

import '../../data/model/issue.dart';


/// create by 张风捷特烈 on 2020/9/3
/// contact me by email 1981462002@qq.com
/// 说明: 

abstract class PointState extends Equatable{

}

class PointLoading extends PointState{
  @override
  List<Object> get props => [];
}

class PointLoaded extends PointState{

 final List<Issue> issues;

 PointLoaded(this.issues);

  @override
  List<Object> get props => [issues];
}


class PointLoadFailure extends PointState{

 final String error;

 PointLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}