import 'package:equatable/equatable.dart';
import '../repository/model/model.dart';

abstract class PackageState {
  const PackageState();
}

class PackageInitial extends PackageState {}

class PackageLoading extends PackageState {}

class PackageLoaded extends PackageState {
  final Map<String, PackageResult> categoryPackages;
  final Set<String> loadingCategories;

  const PackageLoaded(
    this.categoryPackages, {
    this.loadingCategories = const {},
  });
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
  static PackageResult empty = PackageResult(total: 0, data: []);
}
