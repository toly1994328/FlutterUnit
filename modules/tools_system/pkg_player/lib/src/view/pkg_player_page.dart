import 'package:flutter/material.dart';
import 'package:pkg_player/pkg_player.dart';

import '../repository/database/dao/category_dao.dart';
import '../repository/database/dao/package_dao.dart';
import 'plugin_item.dart';

class PkgPlayerPage extends StatefulWidget {
  @override
  _PkgPlayerPageState createState() => _PkgPlayerPageState();
}

class _PkgPlayerPageState extends State<PkgPlayerPage>
    with SingleTickerProviderStateMixin {
  final PackageDao _packageDao = PackageDao();
  final CategoryDao _categoryDao = CategoryDao();
  late TabController _tabController;

  List<Map<String, dynamic>> _categories = [];
  Map<int, List<PluginModel>> _categoryPackages = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Flutter插件库')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter插件库'),
        bottom: _categories.isNotEmpty
            ? TabBar(
                controller: _tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                tabs: _categories
                    .map((category) => Tab(text: category['name']))
                    .toList(),
              )
            : null,
      ),
      body: _categories.isNotEmpty
          ? TabBarView(
              controller: _tabController,
              children: _categories.map((category) {
                final packages = _categoryPackages[category['id']] ?? [];
                return ListView.builder(
                  itemCount: packages.length,
                  itemBuilder: (context, index) {
                    return PluginItem(plugin: packages[index]);
                  },
                );
              }).toList(),
            )
          : Center(child: Text('暂无数据')),
    );
  }

  Future<void> _loadData() async {
    try {
      final categories = await _categoryDao.getAll();

      if (categories.isNotEmpty) {
        _tabController = TabController(length: categories.length, vsync: this);

        Map<int, List<PluginModel>> categoryPackages = {};
        for (var category in categories) {
          final packages = await _packageDao.getByCategory(category['id']);
          final pluginModels = <PluginModel>[];

          for (var pkg in packages) {
            final tags = await _packageDao.getTags(pkg['id']);
            final topics = await _packageDao.getTopics(pkg['id']);
            final dependencies = await _packageDao.getDependencies(pkg['id']);

            pluginModels.add(PluginModel(
              name: pkg['name'],
              lastVersion: pkg['last_version'] ?? '',
              lastPublish: pkg['last_publish'] ?? '',
              statistics: Statistics(
                likes: pkg['likes'] ?? 0,
                points: pkg['points'] ?? 0,
                downloads: pkg['downloads'] ?? 0,
              ),
              tags: tags,
              desc: pkg['description'] ?? '',
              publisher: pkg['publisher'] ?? '',
              repository: pkg['repository'],
              topics: topics,
              dependencies: dependencies,
              homepage: pkg['homepage'],
            ));
          }
          categoryPackages[category['id']] = pluginModels;
        }

        setState(() {
          _categories = categories;
          _categoryPackages = categoryPackages;
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('加载数据失败: $e')),
      );
    }
  }
}
