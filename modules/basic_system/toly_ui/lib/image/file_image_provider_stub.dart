import 'package:flutter/widgets.dart';

/// Web 平台不支持直接读取本机文件路径。
ImageProvider<Object> createFileImageProvider(String filePath) {
  return _UnsupportedFileImageProvider(filePath);
}

/// 用于将不支持的本机文件访问转入统一错误渲染流程。
class _UnsupportedFileImageProvider
    extends ImageProvider<_UnsupportedFileImageProvider> {
  const _UnsupportedFileImageProvider(this.filePath);

  /// 无法在当前平台读取的文件路径。
  final String filePath;

  @override
  Future<_UnsupportedFileImageProvider> obtainKey(
    ImageConfiguration configuration,
  ) async {
    return this;
  }

  @override
  ImageStreamCompleter loadImage(
    _UnsupportedFileImageProvider key,
    ImageDecoderCallback decode,
  ) {
    return OneFrameImageStreamCompleter(
      Future<ImageInfo>.error(
        UnsupportedError('当前平台不支持读取本机图片文件：$filePath'),
      ),
    );
  }
}
