import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:pkg_player/pkg_player.dart';
import 'package:pkg_player/src/view/components/dialog/sort_picker.dart';
import 'package:tolyui_refresh/tolyui_refresh.dart' hide RefreshIndicator;

import '../../bloc/bloc.dart';
import '../../bloc/packages/package_state.dart';
import '../../repository/api/request.dart';
import '../../repository/model/sort_type.dart';

import 'empty_list.dart';
import 'pkg_list_with_data.dart';
import 'recommendation_page.dart';

class PkgPlayerPage extends StatelessWidget {
  const PkgPlayerPage({super.key});

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
  SortType _currentSortType = SortType.downloads;

  @override
  Widget build(BuildContext context) {
    PkgL10n l10n = context.pkgL10n;
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: listenCategory,
      builder: (context, state) {
        if (state is CategoryLoaded) {
          final categories = state.categories;
          return Scaffold(
            appBar: buildAppBar(context, categories, l10n),
            body: categories.isNotEmpty
                ? buildContent(categories)
                : EmptyListView(onRefresh: () => _onRefresh(context, '')),
          );
        }

        if (state is CategoryLoading) {
          return Scaffold(
            appBar: AppBar(title: Text(l10n.flutterPluginRepo)),
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is CategoryError) {
          return Scaffold(
            appBar: AppBar(title: Text(l10n.flutterPluginRepo)),
            body:
                Center(child: Text(l10n.loadFailedWithMessage(state.message))),
          );
        }

        return Scaffold(
          appBar: AppBar(title: Text(l10n.flutterPluginRepo)),
          body: Center(child: Text(l10n.noData)),
        );
      },
    );
  }

  void listenCategory(BuildContext context, state) {
    if (state is CategoryLoaded) {
      _categories = state.categories;
      _initTabController(state.categories);
      if (state.categories.isNotEmpty) {
        context
            .read<PackageCubit>()
            .loadPackagesForCategory(state.categories[0].key);
      }
    }
  }

  BlocBuilder<PackageCubit, PackageState> buildContent(
      List<Category> categories) {
    return BlocBuilder<PackageCubit, PackageState>(
      builder: (context, state) {
        if (state is PackageInitial) {
          return Center(child: CircularProgressIndicator());
        }

        return TabBarView(
          controller: _tabController,
          children: categories.map((category) {
            final isLoading = state.isLoading(category.key);
            PackageResult? packages = state.getResult(category.key);
            if (isLoading || packages == null) {
              return Center(child: CircularProgressIndicator());
            }

            if (packages.data.isEmpty) {
              return Center(child: Text('暂无数据'));
            }

            if (packages.data.isNotEmpty) {
              return PkgListWithData(
                onLoading: () => _onLoading(
                  context,
                  category.key,
                ),
                packages: packages.data,
                hasMore: packages.data.length != packages.total,
                onRefresh: () => _refresh(context, category.key),
                controller: controllerMap[category.key]!,
              );
            }

            return RefreshIndicator(
                onRefresh: () => _onRefresh(context, category.key),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 200,
                    child: Center(child: Text('暂无数据')),
                  ),
                ));
          }).toList(),
        );
      },
    );
  }

  AppBar buildAppBar(
    BuildContext context,
    List<Category> categories,
    PkgL10n l10n,
  ) {
    bool isZh = Localizations.localeOf(context).languageCode == 'zh';
    return AppBar(
      title: Text(l10n.flutterPluginRepo),
      leading: IconButton(
        icon: Icon(Icons.upload),
        onPressed: () => _navigateToRecommendation(context),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.filter_list),
          onPressed: () => _showSortDialog(context),
        ),
      ],
      bottom: categories.isNotEmpty
          ? TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              tabs: categories
                  .map((category) => Tab(text: category.label(isZh)))
                  .toList(),
            )
          : null,
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

  void _showSortDialog(BuildContext context) async {
    SortType? sort = await showSortPicker(context, _currentSortType);
    if (sort != null) {
      _currentSortType = sort;
      _applySortFilter();
    }
  }

  void _applySortFilter() {
    if (_categories.isNotEmpty && _tabController != null) {
      final currentIndex = _tabController!.index;
      if (currentIndex < _categories.length) {
        final categoryKey = _categories[currentIndex].key;
        context.read<PackageCubit>().loadPackagesForCategory(
              categoryKey,
              isRefresh: true,
              sortBy: _currentSortType.value,
            );
      }
    }
  }
}
