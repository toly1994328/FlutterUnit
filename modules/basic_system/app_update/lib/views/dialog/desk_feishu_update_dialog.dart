import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:crypto/crypto.dart';
import 'package:app/app.dart';
import 'package:flutter/material.dart';

import 'package:async/async.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:convert/convert.dart';
import '../../model/app_info.dart';
import 'top_bar.dart';

class DeskFeiShuUpdateDialog extends StatefulWidget {
  final AppInfo result;
  // final ValueChanged<String>? onDownloadSuccess;

  const DeskFeiShuUpdateDialog({Key? key, required this.result,}) : super(key: key);

  @override
  State<DeskFeiShuUpdateDialog> createState() => _DeskFeiShuUpdateDialogState();
}

class _DeskFeiShuUpdateDialogState extends State<DeskFeiShuUpdateDialog> {
  final TextStyle noticeStyle =
  const TextStyle(color: Colors.grey, fontSize: 16);
  final TextStyle cancelTextStyle =
  const TextStyle(color: Colors.grey, fontSize: 16);

  final TextStyle subTextStyle = const TextStyle(
      color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold);

  final TextStyle okTextStyle =
  const TextStyle(color: Color(0xffe16b5c), fontSize: 16);

  ValueNotifier<double> progress = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Container(
        height: 360,
        alignment: Alignment.topLeft,
        width: isDesk ? 400 : 320,
        // color: Colors.green,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTitle(),
            Expanded(child: buildContent()),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      // 下载中，不能退出
                      if (progress.value == 0) {
                        // UpgradeChecker.checked = true;
                        Navigator.of(context).pop(false);
                      } else {
                        // Toast.warning('请等待下载完成');
                      }
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
                        upgradeWindows();

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
                          style: okTextStyle,
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContent() {
    return ValueListenableBuilder(
      valueListenable: progress,
      builder: (_, double progress, Widget? child) {
        if (progress == 0) {
          return _buildUpdateInfo();
        }
        return downloadProgress(progress);
      },
    );
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
              '下载中...',
              style: TextStyle(height: 1, fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(
              height: 10,
            ),
            LinearProgressIndicator(
              minHeight: 10,
              value: progress / 100,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("${progress.toStringAsFixed(1)}%",
                    style:
                    TextStyle(height: 1, fontSize: 12, color: Colors.grey)),
                Spacer(),
                Text(
                  "${convertFileSize(((widget.result.appSize) / 100 * (progress)).toInt())}/${convertFileSize(widget.result.appSize)}",
                  style: TextStyle(height: 1, fontSize: 12, color: Colors.grey),
                )
              ],
            )
          ],
        ),
      ),
    );
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
              widget.result.description??'',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTitle() {
    return ValueListenableBuilder(
      valueListenable: progress,
      builder: (_, double progress, Widget? child) {
        String text =
        progress != 0 ? "正在下载更新.." : "蜜蜂 V${widget.result.appVersion} 准备就绪";

        return FeiShuUpdateTopBar(
          text: text,
        );
      },
    );
  }

  void onDownloadWindowsSuccess() async {
    Navigator.pop(context);
    String? downloadUrl = widget.result.appUrl;
    Directory dir = await getApplicationSupportDirectory();
    String savePath = path.join(dir.path, path.basename(downloadUrl));
    File file = File(savePath);
    print("======下载成功:======${file.path}===========");

    Digest digest = await getFileSha256(file.path);
    // if (digest.toString() == widget.result.checkCode) {
    //   Toast.success('更新程序下载完成，即将重新启动!',short: false);
    //   // widget.onDownloadSuccess?.call(savePath);
    // } else {
    //   Toast.error("文件校验失败，请重新下载");
    // }
  }

  static Future<Digest> getFileSha256(String path) async {
    final reader = ChunkedStreamReader(File(path).openRead());
    const chunkSize = 1024 * 1024 * 2;
    var output = AccumulatorSink<Digest>();
    var input = sha256.startChunkedConversion(output);

    try {
      while (true) {
        final chunk = await reader.readChunk(chunkSize);
        if (chunk.isEmpty) {
          break;
        }
        input.add(chunk);
      }
    } finally {
      reader.cancel();
    }
    input.close();

    return output.events.single;
  }


  String convertFileSize(int? size) {
    if (size == null) return '0 Kb';
    double result = size / 1024.0;
    if (result < 1024) {
      return "${result.toStringAsFixed(2)} KB";
    } else if (result > 1024 && result < 1024 * 1024) {
      return "${(result / 1024).toStringAsFixed(2)} MB";
    } else {
      return "${(result / 1024 / 1024).toStringAsFixed(2)} GB";
    }
  }

  void upgradeWindows() async {
    // if (progress.value != 0) {
    //   Toast.warning('正在下载');
    //   progress.value = 0.1;
    //   return;
    // }
    // String? downloadUrl = widget.result.url;
    // if (downloadUrl == null) return;
    // Directory dir = await getApplicationSupportDirectory();
    // String savePath = path.join(dir.path, path.basename(downloadUrl));
    // print('===downloadUrl:$downloadUrl====savePath:$savePath====');
    //
    // context.read<UpdateCubit>().api.dio.download(widget.result.url!, savePath,
    //     onReceiveProgress: onReceiveProgress);
  }

  void onReceiveProgress(int count, int total) {
    progress.value = (count / total) * 100;
    if (total == count) {
      progress.value = 100;
      onDownloadWindowsSuccess();
    }
  }
}
