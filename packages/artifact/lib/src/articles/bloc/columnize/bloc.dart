import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/columnize.dart';
import '../../data/repository/columnize_repository.dart';

class ColumnizeBloc extends Cubit<ColumnizeState> {
  final ColumnizeRepository repository;

  ColumnizeBloc(this.repository) : super(ColumnizeState.initial());

  void init() {
    _loadDataFromDb(requestNet: true);
  }

  Future<void> _loadDataFromDb({bool requestNet = false}) async {
    ///
    List<Columnize> data = await repository.queryByDb();

    //
    if (data.isNotEmpty) {
      emit(ColumnizeState(data));
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
