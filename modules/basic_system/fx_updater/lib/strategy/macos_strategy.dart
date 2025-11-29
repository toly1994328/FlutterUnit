import 'package:url_launcher/url_launcher.dart';
import '../fx_updater.dart';
import 'update_strategy.dart';

class MacOSUpdateStrategy implements UpdateStrategy {
  @override
  Future<void> update(String url, OnProgressChange onProgress) async {
    await launchUrl(Uri.parse(url));
  }
}