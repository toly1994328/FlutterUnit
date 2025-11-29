import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_dio/fx_dio.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../fx_updater.dart';
import '../strategy/update_strategy.dart';

class UpgradeBloc extends Bloc<UpdateEvent, UpdateState> {
  final UpgradeApi api;

  UpgradeBloc({required this.api}) : super(const NoUpdateState()) {
    on<CheckUpdate>(_onCheckUpdate);
    on<DownloadEvent>(_onDownloadEvent);
    on<ProgressChangeEvent>(_onProgressChangeEvent);
  }

  void _onCheckUpdate(CheckUpdate event, Emitter<UpdateState> emit) async {
    emit(const CheckLoadingState());
    ApiRet<AppInfo> ret = await api.fetch(event.appId, event.locale);
    if (ret.failed) {
      emit(UpdateErrorState(error: ret.msg));
      return;
    }
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    AppInfo result = ret.data;
    if (result.shouldUpgrade(version)) {
      emit(ShouldUpdateState(oldVersion: version, info: result));
    } else {
      int time = DateTime.now().millisecondsSinceEpoch;
      emit(NoUpdateState(isChecked: true, checkTime: time));
    }
  }

  void _onDownloadEvent(DownloadEvent event, Emitter<UpdateState> emit) async {
    UpdateState curState = state;
    if (curState is! ShouldUpdateState) return;
    String url = event.appInfo.url;

    void onProgressChange(double progress) {
      add(ProgressChangeEvent(progress: progress));
    }

    onProgressChange(0.001);

    UpdateStrategy strategy = UpdateStrategyFactory.create();
    await strategy.update(url, onProgressChange);
  }

  FutureOr<void> _onProgressChangeEvent(
      ProgressChangeEvent event, Emitter<UpdateState> emit) async {
    UpdateState curState = state;
    if (curState is! ShouldUpdateState) return;
    emit(curState.copyWith(progress: event.progress));
  }
}
