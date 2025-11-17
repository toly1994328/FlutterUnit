import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pkg_player/pkg_player.dart';

import '../bloc/bloc.dart';
import '../repository/api/request.dart';

import 'plugin_item.dart';

class PkgPlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final request = PackageRequest();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CategoryCubit(request)..loadCategories()),
        BlocProvider(create: (context) => PackageCubit(request)),
      ],
      child: _PkgPlayerView(),
    );
  }
}

class _PkgPlayerView extends StatefulWidget {
  @override
  _PkgPlayerViewState createState() => _PkgPlayerViewState();
}

class _PkgPlayerViewState extends State<_PkgPlayerView>
    with TickerProviderStateMixin {
  TabController? _tabController;
  List<Category> _categories = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is CategoryLoaded) {
          _categories = state.categories;
          _initTabController(state.categories.length);
          if (state.categories.isNotEmpty) {
            context.read<PackageCubit>().loadPackagesForCategory(state.categories[0].key);
          }
        }
      },
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return Scaffold(
              appBar: AppBar(title: Text('Flutter插件库')),
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state is CategoryError) {
            return Scaffold(
              appBar: AppBar(title: Text('Flutter插件库')),
              body: Center(child: Text('加载失败: ${state.message}')),
            );
          }

          if (state is CategoryLoaded) {
            final categories = state.categories;

            return Scaffold(
              appBar: AppBar(
                title: Text('Flutter插件库'),
                bottom: categories.isNotEmpty
                    ? TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        tabs: categories
                            .map((category) => Tab(text: category.name))
                            .toList(),
                      )
                    : null,
              ),
              body: categories.isNotEmpty
                  ? BlocBuilder<PackageCubit, PackageState>(
                      builder: (context, packageState) {
                        if (packageState is PackageInitial) {
                          return Center(child: CircularProgressIndicator());
                        }
                        
                        final categoryPackages = packageState is PackageLoaded 
                            ? packageState.categoryPackages 
                            : <String, List<PluginModel>>{};
                        final loadingCategories = packageState is PackageLoaded 
                            ? packageState.loadingCategories 
                            : <String>{};
                            
                        return TabBarView(
                          controller: _tabController,
                          children: categories.map((category) {
                            final packages = categoryPackages[category.key] ?? [];
                            final isLoading = loadingCategories.contains(category.key);
                            final hasBeenLoaded = categoryPackages.containsKey(category.key);
                            
                            if (isLoading || (!hasBeenLoaded && packages.isEmpty)) {
                              return Center(child: CircularProgressIndicator());
                            }
                            
                            return RefreshIndicator(
                              onRefresh: () => _onRefresh(context, category.key),
                              child: packages.isEmpty
                                  ? SingleChildScrollView(
                                      physics: AlwaysScrollableScrollPhysics(),
                                      child: Container(
                                        height: MediaQuery.of(context).size.height - 200,
                                        child: Center(child: Text('暂无数据')),
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: packages.length,
                                      itemBuilder: (context, index) {
                                        return PluginItem(plugin: packages[index]);
                                      },
                                    ),
                            );
                          }).toList(),
                        );
                      },
                    )
                  : RefreshIndicator(
                      onRefresh: () => _onRefresh(context, ''),
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Container(
                          height: MediaQuery.of(context).size.height - 200,
                          child: Center(child: Text('暂无数据')),
                        ),
                      ),
                    ),
            );
          }

          return Scaffold(
            appBar: AppBar(title: Text('Flutter插件库')),
            body: Center(child: Text('暂无数据')),
          );
        },
      ),
    );
  }

  void _initTabController(int length) {
    if (!mounted) return;
    if (_tabController?.length != length) {
      _tabController?.dispose();
      _tabController = TabController(length: length, vsync: this);
      _tabController?.addListener(_onTabChanged);
    }
  }

  void _onTabChanged() {
    if (_tabController != null && _categories.isNotEmpty) {
      final currentIndex = _tabController!.index;
      if (currentIndex < _categories.length) {
        final categoryKey = _categories[currentIndex].key;
        context.read<PackageCubit>().loadPackagesForCategory(categoryKey);
      }
    }
  }

  Future<void> _onRefresh(BuildContext context, String categoryKey) async {
    if (categoryKey.isEmpty) {
      context.read<CategoryCubit>().loadCategories();
    } else {
      context.read<PackageCubit>().clearPackages();
      context.read<PackageCubit>().loadPackagesForCategory(categoryKey);
    }
  }

  @override
  void dispose() {
    _tabController?.removeListener(_onTabChanged);
    _tabController?.dispose();
    super.dispose();
  }
}
