
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/res/style/unit_color.dart';
import 'package:flutter_unit/app/utils/color_utils.dart';
import 'package:flutter_unit/model/category_model.dart';
import 'package:flutter_unit/repositories/itf/category_repository.dart';
import 'package:flutter_unit/storage/po/category_po.dart';

import 'category_event.dart';
import 'category_state.dart';

/// create by 张风捷特烈 on 2020-04-21
/// contact me by email 1981462002@qq.com
/// 说明:

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository repository;

  CategoryBloc({@required this.repository}) : super(const CategoryLoadingState());

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is EventLoadCategory) {
      yield const CategoryLoadingState();
      // 使用 repository 加载 收藏集数据
      final category = await repository.loadCategories();
      yield category.isEmpty
          ? const CategoryEmptyState()
          : CategoryLoadedState(category);
    }

    if (event is EventDeleteCategory) {
      await repository.deleteCategory(event.id);
      add(const EventLoadCategory());
    }

    if (event is EventToggleWidget) {
      await repository.toggleCategory(event.categoryId, event.widgetId);
      add(const EventLoadCategory());
    }

    if (event is EventAddCategory) {
      CategoryPo categoryPo = CategoryPo(
          name: event.name,
          color: event.color ??
              ColorUtils.colorString(UnitColor.collectColorSupport[0]),
          info: event.info ?? '这里什么都没有...',
          created: DateTime.now(),
          updated: DateTime.now());

      final success = await repository.addCategory(categoryPo);

      if (success) {
        yield const AddCategorySuccess();
        add(const EventLoadCategory());
      } else {
        yield const AddCategoryFailed();
      }
    }

    if (event is EventUpdateCategory) {
      CategoryPo categoryPo = CategoryPo(
          id: event.id,
          name: event.name,
          priority: event.priority ?? 0,
          image: event.image ?? '',
          color: event.color ??
              ColorUtils.colorString(UnitColor.collectColorSupport[0]),
          info: event.info ?? '这里什么都没有...',
          updated: DateTime.now());

      final success = await repository.updateCategory(categoryPo);

      if (success) {
//        yield AddCategorySuccess();
        add(const EventLoadCategory());
      } else {
//        yield AddCategoryFailed();
      }
    }

  }

  List<CategoryModel> get categories {
    if(state is CategoryLoadedState){
      return (state as CategoryLoadedState).categories;
    }else{
      return null;
    }
  }
}
