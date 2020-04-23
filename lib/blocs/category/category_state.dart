import 'package:equatable/equatable.dart';
import 'package:flutter_unit/model/category_model.dart';
import 'package:flutter_unit/model/widget_model.dart';

/// create by 张风捷特烈 on 2020-04-21
/// contact me by email 1981462002@qq.com
/// 说明: 

class CategoryState extends Equatable{
  @override
  List<Object> get props => [];

}

class CategoryLoadedState extends CategoryState {
  final List<CategoryModel> categories;

  CategoryLoadedState(this.categories);
  List<Object> get props => [categories];

}

class CategoryEmptyState extends CategoryState{
  List<Object> get props => [];
}


class AddCategorySuccess extends CategoryState{

}


class AddCategoryFailed extends CategoryState{

}
