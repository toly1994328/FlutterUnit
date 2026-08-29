import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:storage/storage.dart';
import 'package:widget_repository/widget_repository.dart';

/// create by 张风捷特烈 on 2020-04-21
/// contact me by email 1981462002@qq.com
/// 说明:

class CategoryDbRepository implements CategoryRepository {
  CategoryDao get categoryDao => AppStorage().flutter<CategoryDao>();

  LikeDao get likeDao => AppStorage().flutter<LikeDao>();

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
  Future<List<WidgetModel>> loadCategoryWidgets(
      {int categoryId = 0, String locale = 'zh-cn'}) async {
    List<Map<String, dynamic>> rawData =
        await categoryDao.loadCollectWidgets(categoryId, locale);
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
      collects
          .add(CategoryTo(widgetIds: ids, model: CategoryPo.fromJson(data[i])));
      if (i == data.length - 1) {
        completer.complete(collects);
      }
    }

    return completer.future;
  }

  @override
  Future<bool> syncCategoryByData(String data, String likeData) async {
    String stage = '解析分类数据';
    int categoryIndex = -1;
    int? categoryId;
    try {
      final dynamic decodedCategories = json.decode(data);
      if (decodedCategories is! List<dynamic>) {
        throw const FormatException('分类数据根节点不是数组');
      }
      final dynamic decodedLikes = json.decode(likeData);
      if (decodedLikes is! List<dynamic>) {
        throw const FormatException('收藏数据根节点不是数组');
      }
      final List<dynamic> categories = decodedCategories;
      final List<int> likeWidgets = decodedLikes
          .map<int>((dynamic value) => (value as num).toInt())
          .toList();
      developer.log(
        '开始恢复云端快照: categories=${categories.length}, '
        'likes=${likeWidgets.length}, dataBytes=${data.length}, '
        'likeDataBytes=${likeData.length}',
        name: 'FlutterUnit.CategorySync',
      );

      stage = '清空本地分类';
      await categoryDao.clear();

      for (categoryIndex = 0;
          categoryIndex < categories.length;
          categoryIndex++) {
        stage = '解析第 ${categoryIndex + 1} 个分类';
        final dynamic rawCategory = categories[categoryIndex];
        if (rawCategory is! Map<String, dynamic>) {
          throw FormatException('分类项不是对象: ${rawCategory.runtimeType}');
        }
        final dynamic rawModel = rawCategory['model'];
        if (rawModel is! Map<String, dynamic>) {
          throw FormatException('分类 model 不是对象: ${rawModel.runtimeType}');
        }
        final CategoryPo po = CategoryPo.fromNetJson(rawModel);
        categoryId = po.id;
        final dynamic rawWidgetIds = rawCategory['widgetIds'];
        if (rawWidgetIds is! List<dynamic>) {
          throw FormatException(
            '分类 widgetIds 不是数组: ${rawWidgetIds.runtimeType}',
          );
        }
        final List<dynamic> widgetIds = rawWidgetIds;
        stage = '写入分类 id=$categoryId, name=${po.name}';
        await addCategory(po);
        if (widgetIds.isNotEmpty && po.id != null) {
          stage = '写入分类组件关系 id=$categoryId, count=${widgetIds.length}';
          await categoryDao.addWidgets(po.id!, widgetIds);
        }
      }

      stage = '恢复收藏数据';
      for (int i = 0; i < likeWidgets.length; i++) {
        stage = '恢复第 ${i + 1} 个收藏 widgetId=${likeWidgets[i]}';
        await likeDao.like(likeWidgets[i]);
      }
      developer.log(
        '云端快照恢复完成: categories=${categories.length}, '
        'likes=${likeWidgets.length}',
        name: 'FlutterUnit.CategorySync',
      );
      return true;
    } catch (error, stackTrace) {
      developer.log(
        '云端快照恢复失败: stage=$stage, categoryIndex=$categoryIndex, '
        'categoryId=$categoryId',
        name: 'FlutterUnit.CategorySync',
        error: error,
        stackTrace: stackTrace,
        level: 1000,
      );
      return false;
    }
  }
}
