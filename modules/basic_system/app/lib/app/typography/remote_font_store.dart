import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

import 'remote_font_package.dart';

/// 提供当前用户的字体缓存目录。
typedef FontDirectoryProvider = Future<Directory> Function();

/// 汇报字体包下载及校验进度，范围为 0 到 1。
typedef FontProgress = void Function(double progress);

/// 下载字体包并验证本地缓存，只解压清单中指定的文件。
class RemoteFontStore {
  RemoteFontStore({
    required this.package,
    required this.directoryProvider,
    Dio? dio,
  }) : _dio = dio ??
            Dio(BaseOptions(connectTimeout: const Duration(seconds: 15)));

  /// 当前需要加载的字体包。
  final RemoteFontPackage package;

  /// 用于跨平台隔离和测试的目录获取入口。
  final FontDirectoryProvider directoryProvider;

  /// 独立公开下载连接，不携带业务接口认证信息。
  final Dio _dio;

  /// 优先使用已校验缓存；缺失或损坏时重新下载。
  Future<Directory> prepare({FontProgress? onProgress}) async {
    final Directory directory = await directoryProvider();
    await directory.create(recursive: true);
    if (await _validCache(directory)) return directory;

    final File archiveFile = File('${directory.path}/package.zip.part');
    try {
      await _download(archiveFile, onProgress);
      final Uint8List bytes = await archiveFile.readAsBytes();
      if (bytes.length != package.size ||
          sha256.convert(bytes).toString() != package.sha256) {
        throw const FormatException('字体压缩包校验失败');
      }
      final Archive archive = ZipDecoder().decodeBytes(bytes, verify: true);
      for (final RemoteFontFile expected in package.files) {
        final List<ArchiveFile> matches = archive.files
            .where((ArchiveFile file) => file.name == expected.name)
            .toList();
        if (matches.length != 1 ||
            !matches.single.isFile ||
            matches.single.size != expected.size) {
          throw FormatException('字体包文件不完整：${expected.name}');
        }
        final Uint8List content = matches.single.content;
        if (sha256.convert(content).toString() != expected.sha256) {
          throw FormatException('字体文件校验失败：${expected.name}');
        }
        // 不信任压缩包内的路径，始终使用预先声明的文件名。
        final File staging = File('${directory.path}/${expected.name}.part');
        await staging.writeAsBytes(content, flush: true);
        await staging.rename('${directory.path}/${expected.name}');
      }
      onProgress?.call(1);
      return directory;
    } finally {
      if (await archiveFile.exists()) await archiveFile.delete();
    }
  }

  Future<bool> _validCache(Directory directory) async {
    for (final RemoteFontFile expected in package.files) {
      final File file = File('${directory.path}/${expected.name}');
      if (!await file.exists() || await file.length() != expected.size) {
        return false;
      }
      if ((await sha256.bind(file.openRead()).first).toString() !=
          expected.sha256) {
        return false;
      }
    }
    return true;
  }

  /// 限制连接、接收和总耗时，失败时保留应用的系统字体。
  Future<void> _download(File target, FontProgress? onProgress) async {
    final CancelToken cancel = CancelToken();
    final Timer deadline =
        Timer(const Duration(minutes: 3), () => cancel.cancel('字体下载超时'));
    void progress(int received, int total) {
      if (received > package.size) cancel.cancel('字体包超过预期大小');
      onProgress?.call((received / package.size).clamp(0, 1) * .95);
    }

    try {
      await _dio.download(package.url, target.path,
          cancelToken: cancel,
          onReceiveProgress: progress,
          options: Options(
              receiveTimeout: const Duration(seconds: 45),
              sendTimeout: const Duration(seconds: 15)));
    } finally {
      deadline.cancel();
    }
  }
}
