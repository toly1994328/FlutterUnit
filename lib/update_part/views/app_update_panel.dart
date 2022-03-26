import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/utils/Toast.dart';
import 'package:flutter_unit/app/utils/convert.dart';
import 'package:flutter_unit/bloc_exp.dart';

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
                '${Convert.convertFileSize((appSize * progress).floor())}/${Convert.convertFileSize(appSize)}',
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
    String info = '检查新版本';
    Widget trail = const SizedBox.shrink();
    if (state is ShouldUpdateState) {
      info = "下载新版本";
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
      info = "新版本下载中...";
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
      // 处理下载的事件
      BlocProvider.of<UpdateBloc>(context)
          .add(DownloadEvent(appInfo: state.info));
    }
  }

  void _listenerByUpdateState(BuildContext context, UpdateState state) {
    if (state is NoUpdateState) {
      if (state.isChecked) {
        Toast.success(context, '当前应用已是最新版本!');
      }
    }
  }
}
