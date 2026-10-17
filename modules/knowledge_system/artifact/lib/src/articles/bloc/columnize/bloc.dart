import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/exp.dart';

class ColumnizeBloc extends Cubit<ColumnizeState> {
  ColumnizeBloc(this.repository) : super(const ColumnizeState(loading: true));

  /// 线上专栏仓储。
  final ColumnizeRepository repository;

  /// 避免并行重复请求。
  bool _fetching = false;

  Future<void> init() => refresh();

  /// 获取最新专栏；空结果与错误均可明确展示。
  Future<void> refresh() async {
    if (_fetching) return;
    _fetching = true;
    emit(ColumnizeState(data: state.data, loading: true));
    try {
      final List<Columnize> data = await repository.query();
      if (!isClosed) emit(ColumnizeState(data: data));
    } catch (error) {
      if (!isClosed) {
        emit(ColumnizeState(data: state.data, error: error.toString()));
      }
    } finally {
      _fetching = false;
    }
  }
}

class ColumnizeState {
  /// 服务端返回的专栏列表。
  final List<Columnize> data;

  /// 请求是否正在执行。
  final bool loading;

  /// 请求失败的原因。
  final String? error;
  const ColumnizeState({
    this.data = const <Columnize>[],
    this.loading = false,
    this.error,
  });
}
