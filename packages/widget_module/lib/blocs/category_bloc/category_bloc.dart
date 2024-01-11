import 'package:storage/storage.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/exp.dart';


part 'category_event.dart';
part 'category_state.dart';

/// create by 张风捷特烈 on 2020-04-21
/// contact me by email 1981462002@qq.com
/// 说明:

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository repository;

  CategoryBloc({required this.repository}) : super(const CategoryLoadingState()){
    on<CategoryEvent>(_onCategoryEvent);
  }

  void _onCategoryEvent(CategoryEvent event,Emitter<CategoryState> emit) async {
    if (event is EventLoadCategory) {
      emit (const CategoryLoadingState());
      // 使用 repository 加载 收藏集数据
      final category = await repository.loadCategories();
       category.isEmpty
          ? emit (const CategoryEmptyState())
          : emit (CategoryLoadedState(category));
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
          color: event.color ?? '#FFF2F2F2',
          info: event.info ?? '这里什么都没有...',
          created: DateTime.now(),
          updated: DateTime.now());

      final success = await repository.addCategory(categoryPo);

      if (success) {
        emit(const AddCategorySuccess()) ;
        add(const EventLoadCategory());
      } else {
        emit(const AddCategoryFailed()) ;
      }
    }

    if (event is EventUpdateCategory) {
      CategoryPo categoryPo = CategoryPo(
          id: event.id,
          name: event.name,
          priority: event.priority ?? 0,
          image: event.image ?? '',
          color: event.color ??'#FFF2F2F2',
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
      return [];
    }
  }
}
