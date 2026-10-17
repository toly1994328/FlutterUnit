import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'remote_font_package.dart';
import 'remote_font_store.dart';

/// 将已验证的字体文件注册到 Flutter 引擎。
typedef FontRegistrar = Future<void> Function(Directory directory);

/// Windows 在线字体的下载、注册和界面通知入口。
class WindowsFontController extends ChangeNotifier {
  WindowsFontController(
      {RemoteFontStore? store, FontRegistrar? registrar, bool? supported})
      : _store = store ??
            RemoteFontStore(
                package: wenKaiLitePackage, directoryProvider: _cacheDirectory),
        _registrar = registrar ?? _register,
        supported = supported ??
            (!kIsWeb && defaultTargetPlatform == TargetPlatform.windows);

  /// 应用内共享字体状态，避免同时下载和重复注册。
  static final WindowsFontController instance = WindowsFontController();

  /// 此功能仅针对 Windows 原生应用启用。
  final bool supported;

  /// 字体文件缓存和完整性校验实现。
  final RemoteFontStore _store;

  /// 引擎注册入口，测试时可替换。
  final FontRegistrar _registrar;

  /// 正在进行的加载任务，用于合并并发调用。
  Future<void>? _pending;

  /// 字体是否已成功注册。
  bool ready = false;

  /// 当前下载及校验进度。
  double progress = 0;

  /// 最近一次失败的用户提示。
  String? error;

  /// 当前是否正在下载或加载缓存。
  bool get loading => _pending != null;

  /// 原始字体就绪前使用中文系统字体，避免引用未注册的字体族。
  String resolveFamily(String selected) {
    if (selected == 'local') return '';
    if (selected != wenKaiLitePackage.family) return selected;
    return supported && ready ? selected : 'Microsoft YaHei';
  }

  /// 下载完成后立即通知主题重建；失败后允许手动重试。
  Future<void> ensureLoaded() {
    if (!supported || ready) return Future<void>.value();
    if (_pending != null) return _pending!;
    final Completer<void> completer = Completer<void>();
    _pending = completer.future;
    error = null;
    progress = 0;
    notifyListeners();
    unawaited(_load(completer));
    return completer.future;
  }

  Future<void> _load(Completer<void> completer) async {
    try {
      final Directory directory = await _store.prepare(onProgress: _progress);
      await _registrar(directory);
      ready = true;
      progress = 1;
    } catch (failure) {
      error = '字体加载失败，请检查网络后重试';
      debugPrint('Windows 字体加载失败：$failure');
    } finally {
      _pending = null;
      notifyListeners();
      completer.complete();
    }
  }

  void _progress(double value) {
    // 避免每个网络分片都触发整棵主题树重建。
    if (value - progress < .01 && value != 1) return;
    progress = value;
    notifyListeners();
  }

  static Future<Directory> _cacheDirectory() async {
    final Directory root = await getApplicationSupportDirectory();
    return Directory('${root.path}/fonts/lxgw-wenkai-lite/'
        '${wenKaiLitePackage.version}');
  }

  /// 从官方文件元数据识别 Regular 和 Medium 的真实字重。
  static Future<void> _register(Directory directory) async {
    final FontLoader loader = FontLoader(wenKaiLitePackage.family);
    for (final RemoteFontFile file in wenKaiLitePackage.files) {
      if (!file.name.endsWith('.ttf')) continue;
      final Uint8List bytes =
          await File('${directory.path}/${file.name}').readAsBytes();
      loader.addFont(Future<ByteData>.value(ByteData.sublistView(bytes)));
    }
    await loader.load();
    final String license =
        await File('${directory.path}/OFL.txt').readAsString();
    Stream<LicenseEntry> licenseEntries() async* {
      yield LicenseEntryWithLineBreaks(
          <String>[wenKaiLitePackage.family], license);
    }

    LicenseRegistry.addLicense(licenseEntries);
    debugPrint(
        'Windows 字体已加载：${wenKaiLitePackage.family} ${wenKaiLitePackage.version}');
  }
}
