import '../../../pkg_player.dart';

abstract class PackageState {
  const PackageState();

  bool isLoading(String key) => false;

  PackageResult? getResult(String key) => null;
}

class PackageInitial extends PackageState {}

class PackageLoading extends PackageState {
  @override
  bool isLoading(String key) => true;
}

class PackageLoaded extends PackageState {
  final Map<String, PackageResult> categoryPackages;
  final Set<String> loadingCategories;

  const PackageLoaded(
    this.categoryPackages, {
    this.loadingCategories = const {},
  });

  @override
  bool isLoading(String key) => loadingCategories.contains(key);

  @override
  PackageResult? getResult(String key) {
    return categoryPackages[key];
  }
}

class PackageError extends PackageState {
  final String message;

  const PackageError(this.message);
}

class PackageResult {
  final int total;
  final List<PluginModel> data;

  PackageResult({
    required this.total,
    required this.data,
  });

  static PackageResult get empty => PackageResult(total: 0, data: []);
}
