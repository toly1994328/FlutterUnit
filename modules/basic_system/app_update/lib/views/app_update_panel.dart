import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:r_upgrade/r_upgrade.dart';
import 'package:utils/utils.dart';
import 'package:l10n/l10n.dart';

import '../bloc/bloc.dart';
import '../bloc/event.dart';
import '../bloc/state.dart';

class AppUpdatePanel extends StatelessWidget {
  const AppUpdatePanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateBloc, UpdateState>(
      builder: _buildByUpdateState,
      listener: _listenerByUpdateState,
    );
  }

  Widget _buildProgress(BuildContext context, double progress, int appSize) {
    return Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Column(
            children: [
              Text(
                '${(progress * 100).toStringAsFixed(2)} %',
                style: const TextStyle(height: 1, fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '${convertFileSize((appSize * progress).floor())}/${convertFileSize(appSize)}',
                style: const TextStyle(height: 1, fontSize: 10, color: Colors.grey),
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
              value: progress,
            ),
          )
        ]);
  }

  Widget _buildByUpdateState(BuildContext context, UpdateState state) {
    String info = context.l10n.checkUpdate;
    Widget trail = const SizedBox.shrink();
    if (state is ShouldUpdateState) {
      info = context.l10n.downloadNewVersion;
      trail = Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              '${state.oldVersion} --> ${state.info.appVersion} ',
              style: const TextStyle(height: 1, fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(width: 5),
            const Icon(Icons.update, color: Colors.green)
          ]);
    }
    if (state is CheckLoadingState) {
      trail = const CupertinoActivityIndicator();
    }
    if (state is DownloadingState) {
      info = context.l10n.downloadingNewVersion;
      trail = _buildProgress(context, state.progress, state.appSize);
    }

    return ListTile(
      title: Text(
        info,
        style: const TextStyle(fontSize: 13),
      ),
      trailing: trail,
      onTap: () => _tapByState(state, context),
    );
  }

  void _tapByState(UpdateState state, BuildContext context) {
    if (state is NoUpdateState) {
      BlocProvider.of<UpdateBloc>(context)
          .add(const CheckUpdate(appName: 'FlutterUnit'));
    }
    if (state is ShouldUpdateState) {
      if(Platform.isIOS){
        // ios 跳转应用商店
        RUpgrade.upgradeFromAppStore('6450545123', false);
        return;
      }
      // 处理下载的事件
      BlocProvider.of<UpdateBloc>(context)
          .add(DownloadEvent(appInfo: state.info));
    }
  }

  void _listenerByUpdateState(BuildContext context, UpdateState state) {
    if (state is NoUpdateState) {
      if (state.isChecked) {
        Toast.success(context, context.l10n.currentIsNew);
      }
    }
  }

   String convertFileSize(int size){
    double result = size / 1024.0;
    if(result<1024){
      return "${result.toStringAsFixed(2)} Kb";
    }else if(result>1024&&result<1024*1024){
      return "${(result/1024).toStringAsFixed(2)} Mb";
    }else{
      return "${(result/1024/1024).toStringAsFixed(2)} Gb";
    }
  }
}
