import 'package:equatable/equatable.dart';
import '../repository/model/model.dart';

abstract class PackageState extends Equatable {
  const PackageState();

  @override
  List<Object> get props => [];
}

class PackageInitial extends PackageState {}

class PackageLoading extends PackageState {}

class PackageLoaded extends PackageState {
  final Map<String, List<PluginModel>> categoryPackages;
  final Set<String> loadingCategories;

  const PackageLoaded(this.categoryPackages, {this.loadingCategories = const {}});

  @override
  List<Object> get props => [categoryPackages, loadingCategories];
}

class PackageError extends PackageState {
  final String message;

  const PackageError(this.message);

  @override
  List<Object> get props => [message];
}