import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mime/mime.dart';

/// 使用原始字节保存图片，Android 相册通道不对 GIF 等资源重新编码。
const MethodChannel readingImageChannel =
    MethodChannel('com.toly1994.flutter_unit/article_images');

/// 下载原图后保存；用户取消文件窗口时返回空，不提示保存成功。
Future<String?> saveReadingImage(String source, {Dio? client}) async {
  final Uri uri = Uri.parse(source);
  if (!<String>['http', 'https'].contains(uri.scheme)) {
    throw const FormatException('图片地址不可用');
  }
  final Dio downloader = client ??
      Dio(BaseOptions(
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 30)));
  final CancelToken cancel = CancelToken();
  void progress(int received, int total) {
    if (received > 64 * 1024 * 1024 || total > 64 * 1024 * 1024) {
      cancel.cancel('图片过大');
    }
  }

  try {
    final Response<List<int>> response = await downloader.get<List<int>>(source,
        options: Options(responseType: ResponseType.bytes),
        cancelToken: cancel,
        onReceiveProgress: progress);
    final Uint8List bytes = Uint8List.fromList(response.data ?? <int>[]);
    final String? declared = response.headers
        .value(Headers.contentTypeHeader)
        ?.split(';')
        .first
        .trim();
    final String? mime = lookupMimeType('', headerBytes: bytes) ??
        (declared?.startsWith('image/') == true ? declared : null);
    if (bytes.isEmpty ||
        bytes.length > 64 * 1024 * 1024 ||
        mime == null ||
        !mime.startsWith('image/')) {
      throw const FormatException('下载的内容不是有效图片');
    }
    final String? extension =
        mime == 'image/jpeg' ? 'jpg' : extensionFromMime(mime);
    if (extension == null) throw const FormatException('不支持保存此图片格式');
    final String name =
        'FlutterUnit_${DateTime.now().microsecondsSinceEpoch}.$extension';
    if (!kIsWeb &&
        defaultTargetPlatform == TargetPlatform.android &&
        mime != 'image/svg+xml') {
      try {
        final String? saved = await readingImageChannel
            .invokeMethod<String>('saveToGallery', <String, Object>{
          'bytes': bytes,
          'name': name,
          'mime': mime,
        });
        if (saved != null) return '已保存到相册 FlutterUnit';
      } on MissingPluginException {
        // Android 9 及以下使用系统保存窗口，不申请整个存储空间的权限。
      }
    }
    final String? saved = await FilePicker.platform.saveFile(
        dialogTitle: '保存图片',
        fileName: name,
        bytes: bytes,
        type: FileType.custom,
        allowedExtensions: <String>[extension]);
    return saved == null ? null : '图片已保存';
  } finally {
    if (client == null) downloader.close(force: true);
  }
}
