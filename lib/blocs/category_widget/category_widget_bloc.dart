import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/blocs/category/category_bloc.dart';
import 'package:flutter_unit/blocs/category/category_event.dart';
import 'package:flutter_unit/repositories/itf/category_repository.dart';

import 'category_widget_event.dart';
import 'category_widget_state.dart';

/// create by 张风捷特烈 on 2020-04-21
/// contact me by email 1981462002@qq.com
/// 说明:

class CategoryWidgetBloc
    extends Bloc<CategoryWidgetEvent, CategoryWidgetState> {
  final CategoryBloc categoryBloc;

  CategoryWidgetBloc({@required this.categoryBloc});

  CategoryRepository get repository => categoryBloc.repository;

  @override
  CategoryWidgetState get initialState => CategoryWidgetEmptyState(); //初始状态

  @override
  Stream<CategoryWidgetState> mapEventToState(
      CategoryWidgetEvent event) async* {
    if (event is EventLoadCategoryWidget) {
      final widgets =
          await repository.loadCategoryWidgets(categoryId: event.categoryId);
      yield widgets.isNotEmpty
          ? CategoryWidgetLoadedState(widgets)
          : CategoryWidgetEmptyState();
      categoryBloc.add(EventLoadCategory());
    }

    if (event is EventToggleCategoryWidget) {
      await repository.toggleCategory(event.categoryId, event.widgetId);
      add(EventLoadCategoryWidget(event.categoryId));
    }
  }
}
