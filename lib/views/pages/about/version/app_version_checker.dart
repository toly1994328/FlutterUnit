import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/app/api/app_info.dart';
import 'package:flutter_unit/app/utils/Toast.dart';
import 'package:flutter_unit/app/utils/convert.dart';
import 'package:flutter_unit/app/utils/http_utils/http_util.dart';
import 'package:flutter_unit/app/utils/http_utils/result_bean.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:package_info/package_info.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class AppVersionChecker extends StatefulWidget {
  const AppVersionChecker({Key key}) : super(key: key);

  @override
  _AppVersionCheckerState createState() => _AppVersionCheckerState();
}

enum VersionState { none, loading, shouldUpdate, downloading }

class _AppVersionCheckerState extends State<AppVersionChecker> {
  final TextStyle labelStyle = TextStyle(fontSize: 13);
  String oldVersion = '';
  String newVersion = '';
  int totalSize =0;
  String url = 'http://toly1994.com/file/FlutterUnit.apk';
  ValueNotifier<VersionState> versionState =
      ValueNotifier<VersionState>(VersionState.none);

  ValueNotifier<double> progress = ValueNotifier<double>(0);

  _doDownload() async {
    Directory dir = await getExternalStorageDirectory();
    String dstPath = path.join(dir.path, 'FlutterUnit.apk');

    if(File(dstPath).existsSync()){
      InstallPlugin.installApk(dstPath, 'com.toly1994.flutter_unit');
      return;
    }

    versionState.value = VersionState.downloading;

    await HttpUtil.getInstance().client.download(url, dstPath,
        onReceiveProgress: _onReceiveProgress,
        options: Options(receiveTimeout: 24 * 60 * 60 * 1000));
    versionState.value = VersionState.none;
    InstallPlugin.installApk(dstPath, 'com.toly1994.flutter_unit');
  }

  void _onReceiveProgress(int count, int total) {
    totalSize = total;
    progress.value = count / total;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('检查新版本', style: labelStyle),
      trailing: ValueListenableBuilder(
        valueListenable: versionState,
        builder: _buildTrailByState,
      ),
      onTap: () async {
        if (versionState.value == VersionState.shouldUpdate &&
            Platform.isAndroid) {
          _doDownload();
          return;
        }

        if (versionState.value == VersionState.downloading) {
          return;
        }

        versionState.value = VersionState.loading;
        ResultBean<AppInfo> result = await AppInfoApi.getAppVersion();
        PackageInfo packageInfo = await PackageInfo.fromPlatform();

        if (result.status) {
          print('${result.data.appName}:${result.data.appVersion}');
          if (packageInfo.version == result.data.appVersion) {
            Toast.success(context, '当前应用已是最新版本!');
            versionState.value = VersionState.none;
          } else {
            oldVersion = packageInfo.version;
            newVersion = result.data.appVersion;
            Toast.green(context, '检测到新版本【${result.data.appVersion}】，可点击更新!');
            versionState.value = VersionState.shouldUpdate;
          }
        } else {
          print('${result.msg}');
          versionState.value = VersionState.none;
        }
      },
    );
  }

  Widget _buildTrailByState(
      BuildContext context, VersionState value, Widget child) {
    switch (value) {
      case VersionState.none:
        return const SizedBox();
      case VersionState.loading:
        return const CupertinoActivityIndicator();
      case VersionState.shouldUpdate:
        return Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                '$oldVersion --> $newVersion ',
                style: TextStyle(height: 1, fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(
                width: 5,
              ),
              const Icon(
                Icons.update,
                color: Colors.green,
              )
            ]);
      case VersionState.downloading:
        return ValueListenableBuilder(
            valueListenable: progress, builder: _buildProgress);
    }
    return const SizedBox();
  }

  Widget _buildProgress(BuildContext context, double value, Widget child) {
    return Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Column(
            children: [
              Text(
                '${(value * 100).toStringAsFixed(2)} %',
                style: TextStyle(height: 1, fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '${Convert.convertFileSize((totalSize * value).floor())}/${Convert.convertFileSize(totalSize)}',
                style: TextStyle(height: 1, fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(
            width: 15,
          ),
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              backgroundColor: Colors.grey,
              value: value,
            ),
          )
        ]);
  }
}
