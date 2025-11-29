import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc.dart';
import '../../bloc/state.dart';
import '../../fx_updater.dart';
import '../../repository/model/app_info.dart';
import 'top_bar.dart';

class UpdateDialog extends StatefulWidget {
  final AppInfo result;
  final ValueChanged<String>? onDownloadSuccess;
  final VoidCallback? onBackHide;
  final VoidCallback? onConfirm;

  const UpdateDialog({
    super.key,
    required this.result,
    this.onDownloadSuccess,
    this.onBackHide,
    this.onConfirm,
  });

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  final TextStyle noticeStyle =
      const TextStyle(color: Colors.grey, fontSize: 16);
  final TextStyle cancelTextStyle =
      const TextStyle(color: Colors.grey, fontSize: 16);

  final TextStyle subTextStyle = const TextStyle(
      color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    UpdateState state = context.watch<UpgradeBloc>().state;
    return WillPopScope(
      onWillPop: () async {
        // UpdateCubit.isShowDialog = false;
        return true;
      },
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Container(
          height: 360,
          alignment: Alignment.topLeft,
          width: kIsDesk ? 400 : 320,
          // color: Colors.green,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //大小为 ${(widget.result.appSize!/1024/1024).toStringAsFixed(1)}M
              buildTitle(state),
              Expanded(child: buildContent(state)),
              buildButtons(state),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContent(UpdateState state) {
    if (state is ShouldUpdateState) {
      if (state.progress > 0) {
        return downloadProgress(state.progress);
      }
      return _buildUpdateInfo();
    }
    return const SizedBox.shrink();
  }

  Widget downloadProgress(double progress) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              progress == 1 ? "文件校验中..." : '下载中...',
              style: TextStyle(height: 1, fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(
              height: 10,
            ),
            LinearProgressIndicator(
              minHeight: 10,
              value: progress,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("${(progress * 100).toStringAsFixed(1)}%",
                    style:
                        TextStyle(height: 1, fontSize: 12, color: Colors.grey)),
                Spacer(),
                Text(
                  "${convertFileSize(((widget.result.size) * (progress)).toInt())}/${convertFileSize(widget.result.size)}",
                  style: TextStyle(height: 1, fontSize: 12, color: Colors.grey),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  String convertFileSize(int? size) {
    if (size == null) return '0 KB';
    double result = size / 1024.0;
    if (result < 1024) {
      return "${result.toStringAsFixed(2)} KB";
    } else if (result > 1024 && result < 1024 * 1024) {
      return "${(result / 1024).toStringAsFixed(2)} MB";
    } else {
      return "${(result / 1024 / 1024).toStringAsFixed(2)} GB";
    }
  }

  Widget _buildUpdateInfo() {
    return SingleChildScrollView(
      child: Container(
        width: 500,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '更新内容: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              widget.result.description ?? '',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTitle(UpdateState state) {
    String text = '';
    if (state is ShouldUpdateState) {
      text = "闪讯 v${state.info.version} 准备就绪";
      if (state.progress > 0) {
        text = "正在下载更新..";
      }
    }
    return UpdateTopBar(text: text);
  }

  Widget buildButtons(UpdateState state) {
    if (state is ShouldUpdateState) {
      if (state.progress > 0) {
        // 下载中
        return Row(
          children: [
            Expanded(
                child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                // widget.onBackHide?.call();
                Navigator.of(context).pop();
                // UpdateCubit.isShowDialog = false;
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: Colors.grey.withAlpha(88),
                            width: 1 / window.devicePixelRatio))),
                height: 50,
                child: Text(
                  '后台执行',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 16),
                ),
              ),
            )),
          ],
        );
      }
      return Row(
        children: [
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.of(context).pop(false);
                // UpdateCubit.isShowDialog = false;
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: Colors.grey.withAlpha(88),
                            width: 1 / window.devicePixelRatio),
                        right: BorderSide(
                            color: Colors.grey.withAlpha(88),
                            width: 1 / window.devicePixelRatio))),
                alignment: Alignment.center,
                height: 50,
                child: Text(
                  '稍后再说',
                  style: cancelTextStyle,
                ),
              ),
            ),
          ),
          Expanded(
              child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              widget.onConfirm?.call();
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: Colors.grey.withAlpha(88),
                          width: 1 / window.devicePixelRatio),
                      right: BorderSide(
                          color: Colors.grey.withAlpha(88),
                          width: 1 / window.devicePixelRatio))),
              alignment: Alignment.center,
              height: 50,
              child: Text(
                '立即升级',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 16),
              ),
            ),
          )),
        ],
      );
    }

    return const SizedBox.shrink();
  }

  void upgradeWindows() async {
    // context.read<UpdateCubit>().doUpdate();
  }
}
