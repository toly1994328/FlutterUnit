import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file/file.dart';
import 'package:file/memory.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// 返回可解码的缓存文件，测试手势和尺寸变换失败后的原图回退。
class ReadingImageCache implements BaseCacheManager {
  /// 为尺寸变换请求模拟失败，原图继续成功。
  final bool failVariants;

  /// 模拟缓存文件，保留图片原始编码用于解码。
  final File image = MemoryFileSystem().file('/image.gif')
    ..writeAsBytesSync(base64Decode(
        'R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7'));
  ReadingImageCache({this.failVariants = false});

  @override
  Stream<FileResponse> getFileStream(String url,
      {String? key,
      Map<String, String>? headers,
      bool withProgress = false}) async* {
    if (failVariants && Uri.parse(url).queryParameters.containsKey('w')) {
      throw StateError('模拟缩放失败');
    }
    yield FileInfo(image, FileSource.Cache,
        DateTime.now().add(const Duration(days: 1)), url);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void configureReadingImageCache({bool failVariants = false}) {
  CachedNetworkImageProvider.defaultCacheManager =
      ReadingImageCache(failVariants: failVariants);
}

void resetReadingImageCache() {
  PaintingBinding.instance.imageCache.clear();
  PaintingBinding.instance.imageCache.clearLiveImages();
}
