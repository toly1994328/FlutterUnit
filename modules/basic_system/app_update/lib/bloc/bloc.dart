import 'dart:async';
import 'dart:io';

import 'package:app/app.dart';
import 'package:app_update/repository/api/upgrade_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:r_upgrade/r_upgrade.dart';
import 'package:fx_dio/fx_dio.dart';
import 'package:url_launcher/url_launcher.dart';
import '../repository/model/app_info.dart';

import 'event.dart';
import 'state.dart';
import 'package:path/path.dart' as p;

class UpgradeBloc extends Bloc<UpdateEvent, UpdateState> {
  final UpgradeApi api;

  UpgradeBloc({required this.api}) : super(const NoUpdateState()) {
    on<CheckUpdate>(_onCheckUpdate);
    on<DownloadEvent>(_onDownloadEvent);
    on<ProgressChangeEvent>(_onProgressChangeEvent);
  }

  void _onCheckUpdate(CheckUpdate event, Emitter<UpdateState> emit) async {
    emit(const CheckLoadingState());
    ApiRet<AppInfo> ret = await api.fetch(event.appId,event.locale);
    if (ret.failed) {
      emit(UpdateErrorState(error: ret.msg));
      return;
    }
    AppInfo result = ret.data;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (result.shouldUpgrade(packageInfo.version)) {
      emit(ShouldUpdateState(oldVersion: packageInfo.version, info: result));
    } else {
      int time = DateTime.now().millisecondsSinceEpoch;
      emit(NoUpdateState(isChecked: true, checkTime: time));
    }
  }

  void _onDownloadEvent(DownloadEvent event, Emitter<UpdateState> emit) async {
    UpdateState curState = state;
    if (curState is! ShouldUpdateState) return;

    void onProgressChange(double progress) {
      add(ProgressChangeEvent(progress: progress));
    }

    onProgressChange(0.001);

    String url = event.appInfo.url;
    if (kIsDesk) {
      handleDesk(url, onProgressChange);
      return;
    }
    handleAndroid(url, onProgressChange);
  }

  void handleDesk(String url, OnProgressChange callback) async {
    if(kAppEnv.isMacOS){
      launchUrl(Uri.parse(url));
      return;
    }
    Dio dio = Dio();
    Directory dir = await getTemporaryDirectory();
    String filePath = p.join(dir.path, p.basename(url));
    Response rep = await dio.download(
      url,
      filePath,
      onReceiveProgress: (c, t) => callback(c / t),
    );
    if (rep.statusCode == 200) {
      await OpenFile.open(filePath);
    }
  }


  late int? id;
  StreamSubscription<DownloadInfo>? subscription;

  void handleAndroid(String url, OnProgressChange callback) async {
    id = await RUpgrade.upgrade(url, fileName: p.basename(url));
    subscription = RUpgrade.stream.listen((DownloadInfo info) {
      double progress = (info.percent ?? 0) / 100;
      if (info.status == DownloadStatus.STATUS_SUCCESSFUL) {
        progress = 1;
        subscription?.cancel();
      }
      callback(progress);
    });
  }

  FutureOr<void> _onProgressChangeEvent(ProgressChangeEvent event, Emitter<UpdateState> emit) async{
    UpdateState curState = state;
    if (curState is! ShouldUpdateState) return;
    emit(curState.copyWith(progress: event.progress));
  }
}
