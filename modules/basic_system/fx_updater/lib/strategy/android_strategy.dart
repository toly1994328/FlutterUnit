import 'package:fx_install_plugin/install_plugin.dart';

import '../fx_updater.dart';
import 'download_mixin.dart';
import 'update_strategy.dart';

class AndroidUpdateStrategy with DownloadMixin implements UpdateStrategy {
  @override
  Future<void> update(String url, OnProgressChange onProgress) async {
    String filePath = await downloadFile(url, onProgress);
    await InstallPlugin.installApk(filePath);
  }
}
