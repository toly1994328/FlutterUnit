import 'dart:async';
import 'dart:convert';

import 'package:flutter_unit/model/category_model.dart';
import 'package:flutter_unit/model/widget_model.dart';
import 'package:flutter_unit/repositories/itf/category_repository.dart';
import 'package:flutter_unit/storage/app_storage.dart';
import 'package:flutter_unit/storage/dao/category_dao.dart';
import 'package:flutter_unit/storage/po/category_po.dart';
import 'package:flutter_unit/storage/po/widget_po.dart';

/// create by 张风捷特烈 on 2020-04-21
/// contact me by email 1981462002@qq.com
/// 说明:

class CategoryDbRepository implements CategoryRepository {
  final AppStorage storage;

  CategoryDao _categoryDao;

  CategoryDbRepository(this.storage) {
    _categoryDao = CategoryDao(storage);
  }

  @override
  Future<bool> addCategory(CategoryPo categoryPo) async {
    int success = await _categoryDao.insert(categoryPo);
    return success != -1;
  }

  @override
  Future<bool> check(int categoryId, int widgetId) async {
    return await _categoryDao.existWidgetInCollect(categoryId, widgetId);
  }

  @override
  Future<void> deleteCategory(int id) async {
    await _categoryDao.deleteCollect(id);
  }

  @override
  Future<List<CategoryModel>> loadCategories() async {
    List<Map<String, dynamic>> data = await _categoryDao.queryAll();
    List<CategoryPo> collects =
        data.map((e) => CategoryPo.fromJson(e)).toList();
    return collects.map(CategoryModel.fromPo).toList();
  }

  @override
  Future<List<WidgetModel>> loadCategoryWidgets({int categoryId = 0}) async {
    List<Map<String, dynamic>> rawData =
        await _categoryDao.loadCollectWidgets(categoryId);
    List<WidgetPo> widgets = rawData.map((e) => WidgetPo.fromJson(e)).toList();
    return widgets.map(WidgetModel.fromPo).toList();
  }

  @override
  Future<void> toggleCategory(int categoryId, int widgetId) async {
    return await _categoryDao.toggleCollect(categoryId, widgetId);
  }

  @override
  Future<List<int>> getCategoryByWidget(int widgetId) async {
    return await _categoryDao.categoryWidgetIds(widgetId);
  }

  @override
  Future<bool> updateCategory(CategoryPo categoryPo) async {
    int success = await _categoryDao.update(categoryPo);
    return success != -1;
  }

  @override
  Future<List<CategoryTo>> loadCategoryData() async {
    List<Map<String, dynamic>> data = await _categoryDao.queryAll();

    Completer<List<CategoryTo>> completer = Completer();
    List<CategoryTo> collects = [];

    if (data.length == 0) {
      completer.complete([]);
    }

    for (int i = 0; i < data.length; i++) {
      List<int> ids = await _categoryDao.loadCollectWidgetIds(data[i]['id']);
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
  Future<List<dynamic>> loadLikesData() async {

    final db = await storage.db;
    var likes = await db.rawQuery("SELECT id "
        "FROM widget WHERE collected = 1 ORDER BY family,lever DESC");
    var likesData = likes.map((e) => e['id']).toList();

    return likesData;
  }


  Future<void> _setLikes(List<dynamic> ids) async {
    if(ids.isEmpty) return;
    final db = await storage.db;
    String sql = 'UPDATE widget SET collected = 1 WHERE ';
    for(int i=0;i<ids.length;i++){
     if(i==0){
       sql += 'id = ${ids[i]} ';
     }else{
       sql += 'OR id = ${ids[i]} ';
     }
    }

    await db.rawUpdate(sql, );
    List<Map<String, dynamic>> data = await db.rawQuery('SELECT id FROM widget WHERE collected = 1', []);
    print(data);
  }

  @override
  Future<bool> syncCategoryByData(String data,String likeData) async {
    try {
      await _categoryDao.clear();
      List<dynamic> dataMap = json.decode(data);
      for (int i = 0; i < dataMap.length; i++) {
        CategoryPo po = CategoryPo.fromNetJson(dataMap[i]["model"]);
        List<dynamic> widgetIds = dataMap[i]["widgetIds"];
        await addCategory(po);
        if(widgetIds.isNotEmpty){
          await _categoryDao.addWidgets(po.id, widgetIds);
        }
      }
      await _setLikes(json.decode(likeData));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
