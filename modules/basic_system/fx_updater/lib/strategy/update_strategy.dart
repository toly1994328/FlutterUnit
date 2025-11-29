import 'dart:io';
import '../fx_updater.dart';
import 'android_strategy.dart';
import 'desktop_strategy.dart';
import 'macos_strategy.dart';

abstract class UpdateStrategy {
  Future<void> update(String url, OnProgressChange onProgress);
}

class UpdateStrategyFactory {
  static UpdateStrategy create() {
    if (Platform.isAndroid) {
      return AndroidUpdateStrategy();
    } else if (Platform.isMacOS) {
      return MacOSUpdateStrategy();
    } else if (kIsDesk) {
      return DesktopUpdateStrategy();
    }
    throw UnsupportedError('Unsupported platform');
  }
}
