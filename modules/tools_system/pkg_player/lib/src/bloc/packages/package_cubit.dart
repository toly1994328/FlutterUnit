import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pkg_player/src/bloc/packages/package_state.dart';
import '../../repository/api/request.dart';
import '../../repository/model/model.dart';

class PackageCubit extends Cubit<PackageState> {
  final PackageRequest _request;
  final Map<String, PackageResult> _categoryPackages = {};
  final Set<String> _loadingCategories = {};

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
      ;
      emit(PackageLoaded(_categoryPackages,
          loadingCategories: _loadingCategories));
    }
  }

  Future<bool> loadMore(String key) async {
    PackageResult? lastResult = _categoryPackages[key];
    List<PluginModel> current = lastResult?.data ?? [];
    if (current.length == lastResult?.total) {
      return true;
    }
    int page = current.length ~/ 10 + 1;
    final result = await _request.getCategoriesPackage(
      key: key,
      page: page,
      pageSize: 10,
    );
    bool noData = false;
    if (result.success) {
      int total = result.paginate?.total ?? 0;
      List<PluginModel> newModels = [...current, ...result.data];
      noData = total == newModels.length;
      _categoryPackages[key] = PackageResult(total: total, data: newModels);
      emit(
        PackageLoaded(
          Map.from(_categoryPackages),
          loadingCategories: Set.from(_loadingCategories),
        ),
      );
    } else {}

    return noData;
  }

  void clearPackages() {
    _categoryPackages.clear();
    _loadingCategories.clear();
    emit(PackageLoaded({}));
  }
}
