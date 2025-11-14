import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:pkg_player/pkg_player.dart';
import 'package_dao.dart';
import 'category_dao.dart';
import 'tag_dao.dart';
import 'topic_dao.dart';

class PackageService {
  final PackageDao _packageDao = PackageDao();
  final CategoryDao _categoryDao = CategoryDao();
  final TagDao _tagDao = TagDao();
  final TopicDao _topicDao = TopicDao();

  Future<void> savePluginModel(PluginModel plugin, String categoryKey) async {
    // 获取或创建分类
    Map<String, dynamic>? category = await _categoryDao.getByKey(categoryKey);
    if (category == null) {
      // 从category.json获取分类信息并创建
      final categoryInfo = await _getCategoryInfo(categoryKey);
      final categoryId = await _categoryDao.insert(
          categoryKey, categoryInfo['name']!, categoryInfo['desc']!);
      category = {'id': categoryId};
    }

    // 插入包信息
    final packageId = await _packageDao.insert({
      'name': plugin.name,
      'last_version': plugin.lastVersion,
      'last_publish': plugin.lastPublish,
      'likes': plugin.statistics.likes,
      'points': plugin.statistics.points,
      'downloads': plugin.statistics.downloads,
      'description': plugin.desc,
      'publisher': plugin.publisher,
      'repository': plugin.repository ?? '',
      'homepage': plugin.repository ?? '',
    });

    // 插入包分类关联
    await _packageDao.insertPackageCategory(packageId, category['id']);

    // 插入标签
    if (plugin.tags.isNotEmpty) {
      await _packageDao.insertTags(packageId, plugin.tags);
    }

    // 插入主题
    if (plugin.topics.isNotEmpty) {
      await _packageDao.insertTopics(packageId, plugin.topics);
    }

    // 插入依赖
    if (plugin.dependencies != null && plugin.dependencies!.isNotEmpty) {
      await _packageDao.insertDependencies(packageId, plugin.dependencies!);
    }
  }

  Future<void> savePluginModels(
      List<PluginModel> plugins, String categoryKey) async {
    for (PluginModel plugin in plugins) {
      try {
        await savePluginModel(plugin, categoryKey);
      } catch (e, s) {
        print('Failed to save plugin ${plugin.name}: $e,$s');
      }
    }
  }

  Future<Map<String, String>> _getCategoryInfo(String categoryKey) async {
    try {
      String jsonString =
          await rootBundle.loadString('assets/test/category.json');
      Map<String, dynamic> categories = json.decode(jsonString);

      if (categories.containsKey(categoryKey)) {
        return {
          'name': categories[categoryKey]['name'],
          'desc': categories[categoryKey]['desc'],
        };
      }
    } catch (e) {
      print('Failed to load category info: $e');
    }

    // 默认值
    return {
      'name': categoryKey,
      'desc': '未知分类',
    };
  }

  Future<void> clearAllData() async {
    await _packageDao.deleteAll();
    await _categoryDao.deleteAll();
    await _tagDao.deleteAll();
    await _topicDao.deleteAll();
  }
}
