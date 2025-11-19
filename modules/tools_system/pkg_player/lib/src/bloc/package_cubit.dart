import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/api/request.dart';
import '../repository/model/model.dart';
import 'package_state.dart';

class PackageCubit extends Cubit<PackageState> {
  final PackageRequest _request;
  final Map<String, PackageResult> _categoryPackages = {};
  final Set<String> _loadingCategories = {};

  PackageCubit(this._request) : super(PackageInitial());

  Future<void> loadPackagesForCategory(String categoryKey,
      {bool isRefresh = false}) async {
    if (!isRefresh) {
      if (_categoryPackages.containsKey(categoryKey)) return;
      _loadingCategories.add(categoryKey);
    }
    emit(
      PackageLoaded(
        _categoryPackages,
        loadingCategories: Set.from(_loadingCategories),
      ),
    );

    try {
      final result = await _request.getCategoriesPackage(key: categoryKey);

      if (result.success) {
        _categoryPackages[categoryKey] = PackageResult(
          total: result.paginate?.total ?? 0,
          data: result.data,
        );
      } else {
        _categoryPackages[categoryKey] = PackageResult.empty;
      }

      _loadingCategories.remove(categoryKey);
      emit(PackageLoaded(
        _categoryPackages,
        loadingCategories: Set.from(_loadingCategories),
      ));
    } catch (e) {
      _loadingCategories.remove(categoryKey);
      _categoryPackages[categoryKey] = PackageResult.empty;
      ;
      emit(PackageLoaded(Map.from(_categoryPackages),
          loadingCategories: Set.from(_loadingCategories)));
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
          _categoryPackages,
          loadingCategories: _loadingCategories,
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
