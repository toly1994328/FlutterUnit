import 'dart:io';

import 'package:flutter/widgets.dart';

/// 为原生平台创建本机文件图片提供器。
ImageProvider<Object> createFileImageProvider(String filePath) {
  return FileImage(File(filePath));
}
