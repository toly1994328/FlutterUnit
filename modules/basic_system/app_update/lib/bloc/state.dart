import 'package:equatable/equatable.dart';

import '../repository/model/app_info.dart';

sealed class UpdateState extends Equatable {
  const UpdateState();
}

class NoUpdateState extends UpdateState {
  final bool isChecked;
  final int checkTime;

  const NoUpdateState({this.isChecked = false, this.checkTime = 0});

  @override
  List<Object?> get props => [isChecked, checkTime];
}

class CheckLoadingState extends UpdateState {
  const CheckLoadingState();

  @override
  List<Object?> get props => [];
}


class UpdateErrorState extends UpdateState {
  final String error;

  const UpdateErrorState({required this.error});

  @override
  List<Object?> get props => [error];

  @override
  String toString() {
    return 'CheckErrorState{error: $error}';
  }
}

class ShouldUpdateState extends UpdateState {
  final String oldVersion;
  final double progress;
  final AppInfo info;

  const ShouldUpdateState({
    required this.oldVersion,
    required this.info,
    this.progress = 0,
  });

  @override
  List<Object?> get props => [oldVersion, info,progress];

  @override
  String toString() {
    return 'ShouldUpdateState{oldVersion: $oldVersion, info: $info}';
  }

  bool get isDownloading => progress > 0 && progress != 1;
  String get progressDisplay => "${(progress * 100).toStringAsFixed(2)}%";

  UpdateState copyWith({double? progress}) {
    return ShouldUpdateState(
      oldVersion: oldVersion,
      info: info,
      progress: progress ?? this.progress,
    );
  }
}
