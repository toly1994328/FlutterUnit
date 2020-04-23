
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/repositories/itf/category_repository.dart';
import 'package:flutter_unit/storage/po/category_po.dart';

import 'category_event.dart';
import 'category_state.dart';

/// create by 张风捷特烈 on 2020-04-21
/// contact me by email 1981462002@qq.com
/// 说明: 

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository repository;

  CategoryBloc({@required this.repository}){
   print('CategoryBloc') ;
  }

  @override
  CategoryState get initialState => CategoryEmptyState(); //初始状态

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    print('CategoryBloc');
//    if (event is ToggleCategoryEvent) {
//      await repository.toggleCategory(event.id);
//      var collected= await repository.checkCategoryed(1, event.id);
//      yield ToggleCategorySuccess(collected);
//    }
//    if (event is CheckCategoryEvent) {
//      var collected = await repository.checkCategoryed(1, event.id);
//      yield CheckCategorySuccess(collected);
//    }

    if (event is EventLoadCategory) {
      final category = await repository.loadCategories();
      yield category.isEmpty?CategoryEmptyState():CategoryLoadedState(category);
    }

    if (event is EventDeleteCategory) {
      await repository.deleteCategory(event.id);
      add(EventLoadCategory());
    }
    if (event is EventToggleWidget) {
      await repository.toggleCategory(event.categoryId,event.widgetId);
      add(EventLoadCategory());
    }

    if (event is EventAddCategory) {
      var categoryPo = CategoryPo(
          name: event.name,
          color: event.color ?? '#FF2196F3',
          info: event.info ?? '这里什么都没有...',
          created: DateTime.now(),
          updated: DateTime.now());

      final success = await repository.addCategory(categoryPo);

      if (success) {
        yield AddCategorySuccess();
        add(EventLoadCategory());
      }else{
        yield AddCategoryFailed();
      }
    }


//    if (event is EventAddCategory) {
//      var collectPo = CategoryPo(
//          name: event.name,
//          color: event.color ?? '#FF2196F3',
//          info: event.info ?? '这里什么都没有...',
//          created: DateTime.now(),
//          updated: DateTime.now());
//
//      final success = await repository.addCategory(collectPo);
//
//      if (success) {
//        yield AddCategorySuccess();
//        final collect = await repository.loadCategorys();
//        yield LoadCategorySuccess(collects: collect);
//      }
//    }
//    if (event is EventDeleteCategory) {
//      await repository.deleteCategory(event.id);
//      final collect = await repository.loadCategorys();
//      yield LoadCategorySuccess(collects: collect);
//    }
  }
}