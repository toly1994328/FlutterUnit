import 'package:equatable/equatable.dart';
import 'package:flutter_unit/model/category_model.dart';

/// create by 张风捷特烈 on 2020-04-21
/// contact me by email 1981462002@qq.com
/// 说明:

class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryLoadedState extends CategoryState {
  final List<CategoryModel> categories;

  const CategoryLoadedState(this.categories);

  List<Object> get props => [categories];
}

class CategoryLoadingState extends CategoryState {
  const CategoryLoadingState();

  List<Object> get props => [];
}


class CategoryEmptyState extends CategoryState {
  const CategoryEmptyState();

  List<Object> get props => [];
}

class AddCategorySuccess extends CategoryState {
  const AddCategorySuccess();
}

class AddCategoryFailed extends CategoryState {
  const AddCategoryFailed();
}
