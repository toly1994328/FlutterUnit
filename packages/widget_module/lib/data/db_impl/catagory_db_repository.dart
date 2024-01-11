import 'dart:async';
import 'dart:convert';

import 'package:storage/storage.dart';

import '../exp.dart';



/// create by 张风捷特烈 on 2020-04-21
/// contact me by email 1981462002@qq.com
/// 说明:

class CategoryDbRepository implements CategoryRepository {

  CategoryDao get categoryDao => FlutterDbStorage.instance.categoryDao;
  LikeDao get likeDao => FlutterDbStorage.instance.likeDao;

  // CategoryDbRepository({required this.categoryDao,required this.likeDao});

  @override
  Future<bool> addCategory(CategoryPo categoryPo) async {
    int success = await categoryDao.insert(categoryPo);
    return success != -1;
  }

  @override
  Future<bool> check(int categoryId, int widgetId) async {
    return await categoryDao.existWidgetInCollect(categoryId, widgetId);
  }

  @override
  Future<void> deleteCategory(int id) async {
    await categoryDao.deleteCollect(id);
  }

  @override
  Future<List<CategoryModel>> loadCategories() async {
    List<Map<String, dynamic>> data = await categoryDao.queryAll();
    List<CategoryPo> collects =
        data.map((e) => CategoryPo.fromJson(e)).toList();
    return collects.map(CategoryModel.fromPo).toList();
  }

  @override
  Future<List<WidgetModel>> loadCategoryWidgets({int categoryId = 0}) async {
    List<Map<String, dynamic>> rawData =
        await categoryDao.loadCollectWidgets(categoryId);
    List<WidgetPo> widgets = rawData.map((e) => WidgetPo.fromJson(e)).toList();
    return widgets.map(WidgetModel.fromPo).toList();
  }

  @override
  Future<void> toggleCategory(int categoryId, int widgetId) async {
    return await categoryDao.toggleCollect(categoryId, widgetId);
  }

  @override
  Future<List<int>> getCategoryByWidget(int widgetId) async {
    return await categoryDao.categoryWidgetIds(widgetId);
  }

  @override
  Future<bool> updateCategory(CategoryPo categoryPo) async {
    int success = await categoryDao.update(categoryPo);
    return success != -1;
  }

  @override
  Future<List<CategoryTo>> loadCategoryData() async {
    List<Map<String, dynamic>> data = await categoryDao.queryAll();

    Completer<List<CategoryTo>> completer = Completer();
    List<CategoryTo> collects = [];

    if (data.isEmpty) {
      completer.complete([]);
    }

    for (int i = 0; i < data.length; i++) {
      List<int> ids = await categoryDao.loadCollectWidgetIds(data[i]['id']);
      collects.add(CategoryTo(
          widgetIds: ids,
          model: CategoryPo.fromJson(data[i])));

      if (i == data.length - 1) {
        completer.complete(collects);
      }
    }

    return completer.future;
  }

  @override
  Future<bool> syncCategoryByData(String data,String likeData) async {
    try {
      await categoryDao.clear();
      List<dynamic> dataMap = json.decode(data);
      for (int i = 0; i < dataMap.length; i++) {
        CategoryPo po = CategoryPo.fromNetJson(dataMap[i]["model"]);
        List<dynamic> widgetIds = dataMap[i]["widgetIds"];
        await addCategory(po);
        if (widgetIds.isNotEmpty&&po.id!=null) {
          await categoryDao.addWidgets(po.id!, widgetIds);
        }
      }
      List<int> likeWidgets = (json.decode(likeData) as List).map<int>((e) => e).toList();
      for (int i = 0; i < likeWidgets.length; i++) {
        await likeDao.like(likeWidgets[i]);
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
