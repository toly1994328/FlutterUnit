import 'package:url_launcher/url_launcher.dart';
import '../fx_updater.dart';
import 'download_mixin.dart';
import 'update_strategy.dart';

class DesktopUpdateStrategy with DownloadMixin implements UpdateStrategy {
  @override
  Future<void> update(String url, OnProgressChange onProgress) async {
    String filePath = await downloadFile(url, onProgress);
    await launchUrl(Uri.file(filePath));
  }
}