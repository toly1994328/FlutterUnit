import 'package:flutter_unit/model/category_model.dart';
import 'package:flutter_unit/model/widget_model.dart';
import 'package:flutter_unit/storage/po/category_po.dart';

/// create by 张风捷特烈 on 2020-04-21
/// contact me by email 1981462002@qq.com
/// 说明: 

abstract class CategoryRepository {

  Future<void> toggleCategory(int id);

  Future<bool> check(int categoryId,int widgetId);

  Future<List<WidgetModel>> loadCategoryWidgets({int categoryId = 0});


  Future<List<CategoryModel>> loadCategories();

  Future<bool> addCategory(CategoryPo categoryPo);

  Future<void> deleteCategory(int id);

}