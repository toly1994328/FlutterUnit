import 'dart:async';

import 'package:app/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:r_upgrade/r_upgrade.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:utils/utils.dart';

import '../model/app_info.dart';
import 'event.dart';
import 'state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  UpdateBloc() : super(const NoUpdateState()) {
    on<CheckUpdate>(_onCheckUpdate);
    on<ResetNoUpdate>(_onResetNoUpdate);
    on<DownloadEvent>(_onDownloadEvent);
    on<DownloadingEvent>(_onDownloadingEvent);
  }

  void _onCheckUpdate(CheckUpdate event, Emitter<UpdateState> emit) async {
    print("========_onCheckUpdate==============");
    emit(const CheckLoadingState());
    // await Future.delayed(Duration(seconds: 1));
    // 检测更新逻辑
    TaskResult<AppInfo> result = await AppInfoApi.getAppVersion(appName: event.appName);
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    print(result);
    if (result.success && result.data != null) {
      if (packageInfo.version == result.data!.appVersion) {
        emit(NoUpdateState(
          isChecked: true,
          checkTime: DateTime.now().millisecondsSinceEpoch,
        ));
      } else {
        if (result.data != null) {
          emit(ShouldUpdateState(
              oldVersion: packageInfo.version, info: result.data!));
        }
      }
    } else {
      emit(CheckErrorState(error: result.msg));
    }
  }

  void _onResetNoUpdate(ResetNoUpdate event, Emitter<UpdateState> emit) {
    emit(const NoUpdateState());
  }

  late int? id;
  late StreamSubscription<DownloadInfo>? subscription;

  void _launchURL(String url) async {
    print(url);
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(uri,mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  void _onDownloadEvent(DownloadEvent event, Emitter<UpdateState> emit) async{
    if(isDesk){
      // 桌面端跳转到下载地址
      _launchURL('https://github.com/toly1994328/FlutterUnit/releases');
      return;
    }

    id = await RUpgrade.upgrade(event.appInfo.appUrl, fileName: '${event.appInfo.appName}.apk',);
    subscription = RUpgrade.stream.listen((DownloadInfo info) {
      double progress = (info.percent ?? 0) / 100;
      if (info.status! == DownloadStatus.STATUS_SUCCESSFUL) {
        progress = 1;
        subscription?.cancel();
        add(const ResetNoUpdate());
      }
      add(DownloadingEvent(state: DownloadingState(
          appSize: event.appInfo.appSize,
          progress: progress
      )));
    });
  }

  void _onDownloadingEvent(DownloadingEvent event, Emitter<UpdateState> emit) {
    emit(event.state);
  }
}
