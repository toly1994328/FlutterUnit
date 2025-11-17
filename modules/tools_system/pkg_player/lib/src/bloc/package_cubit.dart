import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/api/request.dart';
import '../repository/model/model.dart';
import 'package_state.dart';

class PackageCubit extends Cubit<PackageState> {
  final PackageRequest _request;
  final Map<String, List<PluginModel>> _categoryPackages = {};
  final Set<String> _loadingCategories = {};

  PackageCubit(this._request) : super(PackageInitial());

  Future<void> loadPackagesForCategory(String categoryKey) async {
    if (_categoryPackages.containsKey(categoryKey)) return;
    
    _loadingCategories.add(categoryKey);
    emit(PackageLoaded(Map.from(_categoryPackages), loadingCategories: Set.from(_loadingCategories)));
    
    try {
      final result = await _request.getCategoriesPackage(key: categoryKey);
      
      if (result.success) {
        _categoryPackages[categoryKey] = result.data;
      } else {
        _categoryPackages[categoryKey] = [];
      }
      
      _loadingCategories.remove(categoryKey);
      emit(PackageLoaded(Map.from(_categoryPackages), loadingCategories: Set.from(_loadingCategories)));
    } catch (e) {
      _loadingCategories.remove(categoryKey);
      _categoryPackages[categoryKey] = [];
      emit(PackageLoaded(Map.from(_categoryPackages), loadingCategories: Set.from(_loadingCategories)));
    }
  }

  void clearPackages() {
    _categoryPackages.clear();
    _loadingCategories.clear();
    emit(PackageLoaded({}));
  }
}