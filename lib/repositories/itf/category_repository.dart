import 'package:flutter_unit/model/category_model.dart';
import 'package:flutter_unit/model/widget_model.dart';
import 'package:flutter_unit/storage/po/category_po.dart';

/// create by 张风捷特烈 on 2020-04-21
/// contact me by email 1981462002@qq.com
/// 说明: 负责数据的存储和操作接口

abstract class CategoryRepository {
  //切换一个组件在收藏夹中的状态
  Future<void> toggleCategory(int categoryId, int widgetId);

  // 检查一个组件是否在收藏夹内
  Future<bool> check(int categoryId,int widgetId);

  // 获取一个收藏夹中的所有组件
  Future<List<WidgetModel>> loadCategoryWidgets({int categoryId = 0});

  // 获取所有收藏集
  Future<List<CategoryModel>> loadCategories();

  //添加收藏集
  Future<bool> addCategory(CategoryPo categoryPo);

  //更新收藏集
  Future<bool> updateCategory(CategoryPo categoryPo);

  //删除收藏集
  Future<void> deleteCategory(int id);

  //查看某个组件在哪些收藏集中
  Future<List<int>> getCategoryByWidget(int widgetId);

}