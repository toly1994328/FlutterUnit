import 'package:equatable/equatable.dart';

import '../repository/model/app_info.dart';

sealed class UpdateEvent extends Equatable {
  const UpdateEvent();
}

// 检查更新 ---> 校验，转换状态
class CheckUpdate extends UpdateEvent {
  final int appId;
  final String locale;

  const CheckUpdate({required this.appId,required this.locale, });

  @override
  List<Object?> get props => [appId];
}

class DownloadEvent extends UpdateEvent {
  final AppInfo appInfo;

  const DownloadEvent({required this.appInfo});

  @override
  List<Object?> get props => [appInfo];
}

class ProgressChangeEvent extends UpdateEvent {
  final double progress;

  const ProgressChangeEvent({required this.progress});

  @override
  List<Object?> get props => [progress];
}
