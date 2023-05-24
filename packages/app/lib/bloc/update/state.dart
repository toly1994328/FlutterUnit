// import 'package:equatable/equatable.dart';
// import 'package:flutter_unit/point_system/api/app_info.dart';
//
// abstract class UpdateState extends Equatable {
//   const UpdateState();
// }
//
// class NoUpdateState extends UpdateState {
//   final bool isChecked;
//   final int checkTime;
//
//   const NoUpdateState({this.isChecked = false, this.checkTime = 0});
//
//   @override
//   List<Object?> get props => [isChecked, checkTime];
// }
//
// class CheckLoadingState extends UpdateState {
//   const CheckLoadingState();
//   @override
//   List<Object?> get props => [];
// }
//
// class DownloadingState extends UpdateState {
//   final double progress;
//   final int appSize;
//
//   const DownloadingState({required this.progress, required this.appSize});
//
//   @override
//   List<Object?> get props => [progress, appSize];
// }
//
// class CheckErrorState extends UpdateState {
//   final String error;
//
//   const CheckErrorState({required this.error});
//
//   @override
//   List<Object?> get props => [error];
//
//   @override
//   String toString() {
//     return 'CheckErrorState{error: $error}';
//   }
// }
//
// class ShouldUpdateState extends UpdateState {
//   final String oldVersion;
//   final AppInfo info;
//
//   const ShouldUpdateState({required this.oldVersion, required this.info});
//
//   @override
//   List<Object?> get props => [oldVersion, info];
//
//   @override
//   String toString() {
//     return 'ShouldUpdateState{oldVersion: $oldVersion, info: $info}';
//   }
// }
