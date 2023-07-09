import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utils/utils.dart';

import '../../repositories/model/columnize.dart';
import '../../repositories/repository/columnize_repository.dart';

class ColumnizeBloc extends Cubit<ColumnizeState> {
  final ColumnizeRepository repository;

  ColumnizeBloc(this.repository) : super(ColumnizeState.initial());

  void init() {
    _loadDataFromNet(requestNet: true);
  }

  Future<void> _loadDataFromNet({bool requestNet = false}) async {
    /// 没有内存缓存时，查看数据库数据
    List<Columnize> data = await repository.queryByDbCache();

    // 没有内存缓存 并且数据库有数据
    if (data.isNotEmpty) {
      emit(ColumnizeState(data));
      if (!requestNet) return;
    }

    await _requestNetAndSaveOrUpdate();
  }

  Future<void> _requestNetAndSaveOrUpdate() async {
    // 此时表示没有缓存数据，并且需要请求网络
    print("=====ColumnizeBloc::请求网络加载数据==========");
    TaskResult<List<Columnize>> result = await repository.queryByHttp();
    if (result.success) {
      emit(ColumnizeState(result.data!));
      repository.cacheResult(result.data!);
    } else {
      // emit(PlanFailureState(result.msg,oldData: _cache[groupId] ?? []));
    }
  }
}

class ColumnizeState {
  List<Columnize> data;

  ColumnizeState(this.data);

  factory ColumnizeState.initial() => ColumnizeState([
        Columnize(title: '-', url: '-'),
        Columnize(title: '-', url: '-'),
        Columnize(title: '-', url: '-'),
        Columnize(title: '-', url: '-'),
        Columnize(title: '-', url: '-'),
        Columnize(title: '-', url: '-'),
        Columnize(title: '-', url: '-'),
      ]);
}
