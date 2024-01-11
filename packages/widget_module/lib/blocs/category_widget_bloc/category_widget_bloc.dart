import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/exp.dart';



import '../category_bloc/category_bloc.dart';

part 'category_widget_event.dart';
part 'category_widget_state.dart';

/// create by 张风捷特烈 on 2020-04-21
/// contact me by email 1981462002@qq.com
/// 说明:

class CategoryWidgetBloc
    extends Bloc<CategoryWidgetEvent, CategoryWidgetState> {
  final CategoryBloc categoryBloc;

  CategoryWidgetBloc({required this.categoryBloc})
      : super(CategoryWidgetEmptyState()){
    on<EventLoadCategoryWidget>(_onEventLoadCategoryWidget);
    on<EventToggleCategoryWidget>(_onEventToggleCategoryWidget);
  }

  CategoryRepository get repository => categoryBloc.repository;

  void _onEventLoadCategoryWidget(EventLoadCategoryWidget event, Emitter<CategoryWidgetState> emit) async{
    final widgets =
    await repository.loadCategoryWidgets(categoryId: event.categoryId);
     widgets.isNotEmpty
        ? emit(CategoryWidgetLoadedState(widgets))
        : emit(CategoryWidgetEmptyState());
    categoryBloc.add(const EventLoadCategory());
  }

  void _onEventToggleCategoryWidget(EventToggleCategoryWidget event, Emitter<CategoryWidgetState> emit) async{
    await repository.toggleCategory(event.categoryId, event.widgetId);
    add(EventLoadCategoryWidget(event.categoryId));
  }
}
