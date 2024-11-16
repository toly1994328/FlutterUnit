import 'dart:async';
import 'dart:io';

import 'package:app/app.dart';
import 'package:app_update/repository/api/upgrade_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:r_upgrade/r_upgrade.dart';

import '../model/app_info.dart';

import 'event.dart';
import 'state.dart';
import 'package:path/path.dart' as p;

class UpgradeBloc extends Bloc<UpdateEvent, UpdateState> {
  final UpgradeApi api;

  UpgradeBloc({required this.api}) : super(const NoUpdateState()) {
    on<CheckUpdate>(_onCheckUpdate);
    on<ResetNoUpdate>(_onResetNoUpdate);
    on<DownloadEvent>(_onDownloadEvent);
    on<DownloadingEvent>(_onDownloadingEvent);
  }

  void _onCheckUpdate(CheckUpdate event, Emitter<UpdateState> emit) async {
    print("========_onCheckUpdate==============");
    emit(const CheckLoadingState());
    // 检测更新逻辑
    try {
      AppInfo result = await api.fetch(event.appName);
      print(result);

      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      if (result.shouldUpgrade(packageInfo.version)) {
        emit(NoUpdateState(
          isChecked: true,
          checkTime: DateTime.now().millisecondsSinceEpoch,
        ));
      } else {
        emit(ShouldUpdateState(oldVersion: packageInfo.version, info: result));
      }
    } catch (e) {
      print(e);
      emit(CheckErrorState(error: e.toString()));
    }
  }

  void _onResetNoUpdate(ResetNoUpdate event, Emitter<UpdateState> emit) {
    emit(const NoUpdateState());
  }

  late int? id;
  late StreamSubscription<DownloadInfo>? subscription;

  void _onDownloadEvent(DownloadEvent event, Emitter<UpdateState> emit) async {
    if (isDesk) {
      String url =
          'https://gitee.com/toly1994328/FlutterUnit/releases/download/last/FlutterUnit.exe';
      // 桌面端跳转到下载地址
      // _launchURL('https://github.com/toly1994328/FlutterUnit/releases');
      Dio dio = Dio();
      Directory dir = await getTemporaryDirectory();
      String filePath = p.join(dir.path, 'FlutterUnit.exe');

      Response rep = await dio.download(
        url,
        filePath,
        onReceiveProgress: (c, t) => _onProgressChange(event.appInfo.appSize, c / t),
      );
      if (rep.statusCode == 200) {
        add(const ResetNoUpdate());
        OpenFile.open(filePath);
      }
      return;
    }

    id = await RUpgrade.upgrade(
      event.appInfo.appUrl,
      fileName: '${event.appInfo.appName}.apk',
    );
    subscription = RUpgrade.stream.listen((DownloadInfo info) {
      double progress = (info.percent ?? 0) / 100;
      if (info.status! == DownloadStatus.STATUS_SUCCESSFUL) {
        progress = 1;
        subscription?.cancel();
        add(const ResetNoUpdate());
      }
      _onProgressChange(event.appInfo.appSize, progress);
    });
  }

  void _onProgressChange(int appSize, double progress) {
    add(
      DownloadingEvent(
        state: DownloadingState(appSize: appSize, progress: progress),
      ),
    );
  }

  void _onDownloadingEvent(DownloadingEvent event, Emitter<UpdateState> emit) {
    emit(event.state);
  }
}
