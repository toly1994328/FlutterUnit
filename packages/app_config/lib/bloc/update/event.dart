// import 'package:equatable/equatable.dart';
// import 'package:flutter_unit/point_system/api/app_info.dart';
//
// import 'state.dart';
//
// abstract class UpdateEvent extends Equatable {
//   const UpdateEvent();
// }
//
// // 检查更新 ---> 校验，转换状态
// class CheckUpdate extends UpdateEvent {
//   final String appName;
//
//   const CheckUpdate({required this.appName});
//
//   @override
//   List<Object?> get props => [appName];
// }
//
// class DownloadEvent extends UpdateEvent {
//   final AppInfo appInfo;
//
//   const DownloadEvent({required this.appInfo});
//
//   @override
//   List<Object?> get props => [appInfo];
// }
//
// class DownloadingEvent extends UpdateEvent {
//   final DownloadingState state;
//
//   const DownloadingEvent({required this.state});
//
//   @override
//   List<Object?> get props => [state];
// }
//
// // 将状态重置为 NoUpdateState
// class ResetNoUpdate extends UpdateEvent {
//   const ResetNoUpdate();
//
//   @override
//   List<Object?> get props => [];
// }
