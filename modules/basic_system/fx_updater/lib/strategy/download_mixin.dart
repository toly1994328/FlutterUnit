import 'dart:io';
import 'package:fx_dio/fx_dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../fx_updater.dart';

mixin DownloadMixin {
  Future<String> downloadFile(String url, OnProgressChange onProgress) async {
    Dio dio = Dio();
    Directory dir = await getTemporaryDirectory();
    String filePath = p.join(dir.path, p.basename(url));

    Response rep = await dio.download(
      url,
      filePath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          onProgress(received / total);
        }
      },
    );

    if (rep.statusCode == 200) {
      onProgress(1.0);
      return filePath;
    }
    throw Exception('Download failed');
  }
}