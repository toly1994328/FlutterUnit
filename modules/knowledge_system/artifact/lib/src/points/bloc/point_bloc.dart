import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/api/point_api.dart';
import 'package:equatable/equatable.dart';
import '../data/model/issue.dart';

/// create by 张风捷特烈 on 2020-09-03
/// contact me by email 1981462002@qq.com
/// 说明:

class PointBloc extends Cubit<PointState> {
  final PointApi api;

  PointBloc(this.api) : super(const PointLoading());

  void loadPoint() async {
    emit(const PointLoading());
    ApiRet<List<Issue>> ret = await api.getIssues();
    if(ret.failed){
      emit(PointLoadFailure(ret.msg));
    }
    emit(PointLoaded(ret.data));
  }
}

sealed class PointState extends Equatable {
  const PointState();
}

class PointLoading extends PointState {
  const PointLoading();

  @override
  List<Object> get props => [];
}

class PointLoaded extends PointState {
  final List<Issue> issues;

  const PointLoaded(this.issues);

  @override
  List<Object> get props => [issues];
}

class PointLoadFailure extends PointState {
  final String error;

  const PointLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
