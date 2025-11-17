import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/api/request.dart';
import '../repository/model/model.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final PackageRequest _request;

  CategoryCubit(this._request) : super(CategoryInitial());

  Future<void> loadCategories() async {
    emit(CategoryLoading());

      final result = await _request.getCategories();
      if (result.success) {
        emit(CategoryLoaded(result.data));
      } else {
        emit(CategoryError(result.msg));
      }

  }
}