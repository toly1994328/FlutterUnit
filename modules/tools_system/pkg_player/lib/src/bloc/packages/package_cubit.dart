import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pkg_player/src/bloc/packages/package_state.dart';
import 'package:unit_env/unit_env.dart';

import '../../repository/api/request.dart';
import '../../repository/model/model.dart';

class PackageCubit extends Cubit<PackageState> {
  final PackageRequest _request;
  final Map<String, PackageResult> _categoryPackages = {};
  final Set<String> _loadingCategories = {};

  /// 正在执行上拉分页请求的分类，避免滚动回调并发加载同一页。
  final Set<String> _loadingMoreCategories = {};

  PackageCubit(this._request) : super(PackageInitial());

  Future<void> loadPackagesForCategory(String categoryKey,
      {bool isRefresh = false, String? sortBy}) async {
    // 检查是否需要加载
    if (!isRefresh && _categoryPackages.containsKey(categoryKey)) {
      return;
    }

    // 添加loading状态并立即emit
    if (!isRefresh) {
      _loadingCategories.add(categoryKey);
      final loadingState = PackageLoaded(
        _categoryPackages,
        loadingCategories: _loadingCategories,
      );
      emit(loadingState);
    }

    try {
      final result = await _request.getCategoriesPackage(
        key: categoryKey,
        sortBy: sortBy,
      );

      if (result.success) {
        _categoryPackages[categoryKey] = PackageResult(
          total: result.paginate?.total ?? 0,
          data: result.data,
        );
      } else {
        _categoryPackages[categoryKey] = PackageResult.empty;
      }

      _loadingCategories.remove(categoryKey);
      final completedState = PackageLoaded(
        _categoryPackages,
        loadingCategories: _loadingCategories,
      );
      emit(completedState);
    } catch (e) {
      _loadingCategories.remove(categoryKey);
      _categoryPackages[categoryKey] = PackageResult.empty;
      emit(PackageLoaded(_categoryPackages,
          loadingCategories: _loadingCategories));
    }
  }

  Future<bool> loadMore(String key) async {
    final PackageResult? lastResult = _categoryPackages[key];
    final List<PluginModel> current = lastResult?.data ?? [];
    if (lastResult == null || current.length >= lastResult.total) {
      return true;
    }
    if (!_loadingMoreCategories.add(key)) {
      return false;
    }

    try {
      const int pageSize = 10;
      final int page = current.length ~/ pageSize + 1;
      final ApiRet<List<PluginModel>> result =
          await _request.getCategoriesPackage(
        key: key,
        page: page,
        pageSize: pageSize,
      );
      if (!result.success) {
        return false;
      }

      final int total = result.paginate?.total ?? lastResult.total;
      final List<PluginModel> newModels = [...current, ...result.data];
      _categoryPackages[key] = PackageResult(total: total, data: newModels);
      emit(
        PackageLoaded(
          Map<String, PackageResult>.from(_categoryPackages),
          loadingCategories: Set<String>.from(_loadingCategories),
        ),
      );
      return result.data.isEmpty || newModels.length >= total;
    } finally {
      _loadingMoreCategories.remove(key);
    }
  }

  void clearPackages() {
    _categoryPackages.clear();
    _loadingCategories.clear();
    _loadingMoreCategories.clear();
    emit(PackageLoaded({}));
  }
}
