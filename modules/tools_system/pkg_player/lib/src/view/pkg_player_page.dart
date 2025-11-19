import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pkg_player/pkg_player.dart';
import 'package:tolyui_refresh/tolyui_refresh.dart' hide RefreshIndicator;

import '../bloc/bloc.dart';
import '../repository/api/request.dart';

import 'pkg_list/pkg_list_with_data.dart';
import 'plugin_item.dart';
import 'recommendation_page.dart';

class PkgPlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final request = PackageRequest();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => CategoryCubit(request)..loadCategories()),
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
  final Map<String, RefreshController> controllerMap = {};

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is CategoryLoaded) {
          _categories = state.categories;
          _initTabController(state.categories);
          if (state.categories.isNotEmpty) {
            context
                .read<PackageCubit>()
                .loadPackagesForCategory(state.categories[0].key);
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
                leading: IconButton(
                  icon: Icon(Icons.upload),
                  onPressed: () => _navigateToRecommendation(context),
                ),
                // actions: [
                //   IconButton(
                //     icon: Icon(Icons.upload),
                //     onPressed: () => _navigateToRecommendation(context),
                //   ),
                // ],
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

                        Map<String, PackageResult> categoryPackages =
                            packageState is PackageLoaded
                                ? packageState.categoryPackages
                                : <String, PackageResult>{};
                        final loadingCategories = packageState is PackageLoaded
                            ? packageState.loadingCategories
                            : <String>{};

                        return TabBarView(
                          controller: _tabController,
                          children: categories.map((category) {
                            PackageResult? packages =
                                categoryPackages[category.key];
                            if (packages == null) return SizedBox();
                            final isLoading =
                                loadingCategories.contains(category.key);
                            final hasBeenLoaded =
                                categoryPackages.containsKey(category.key);
                            if (isLoading) {
                              return Center(child: CircularProgressIndicator());
                            }

                            if (packages.data.isNotEmpty) {
                              return PkgListWithData(
                                onLoading: () => _onLoading(
                                  context,
                                  category.key,
                                ),
                                packages: packages.data,
                                onRefresh: () =>
                                    _refresh(context, category.key),
                                controller: controllerMap[category.key]!,
                              );
                            }

                            return RefreshIndicator(
                                onRefresh: () =>
                                    _onRefresh(context, category.key),
                                child: SingleChildScrollView(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height -
                                        200,
                                    child: Center(child: Text('暂无数据')),
                                  ),
                                ));
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

  void _initTabController(List<Category> tabs) {
    if (!mounted) return;
    int length = tabs.length;
    if (_tabController?.length != length) {
      _tabController?.dispose();
      _tabController = TabController(length: length, vsync: this);
      _tabController?.addListener(_onTabChanged);
    }
    if (controllerMap.isEmpty) {
      for (Category category in tabs) {
        controllerMap[category.key] = RefreshController();
      }
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

  void _navigateToRecommendation(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecommendationPage(),
      ),
    );
  }

  @override
  void dispose() {
    _tabController?.removeListener(_onTabChanged);
    _tabController?.dispose();
    super.dispose();
  }

  void _refresh(BuildContext context, String key) async {
    // context.read<PackageCubit>().clearPackages();
    await context
        .read<PackageCubit>()
        .loadPackagesForCategory(key, isRefresh: true);
    controllerMap[key]?.refreshCompleted();
  }

  void _onLoading(BuildContext context, String key) async {
    bool noMore = await context.read<PackageCubit>().loadMore(
          key,
        );
    if (noMore) {
      controllerMap[key]?.loadNoData();
    } else {
      controllerMap[key]?.loadComplete();
    }
  }
}
