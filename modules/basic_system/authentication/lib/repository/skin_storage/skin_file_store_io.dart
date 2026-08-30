import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

/// 将用户皮肤图片保存在应用支持目录。
class UserSkinFileStore {
  /// 复制图片数据并返回稳定的本机文件路径。
  Future<String> save(
    String fileName,
    Uint8List bytes,
  ) async {
    final Directory supportDirectory = await getApplicationSupportDirectory();
    final Directory skinDirectory =
        Directory('${supportDirectory.path}/user_skins');
    await skinDirectory.create(recursive: true);
    final File target = File('${skinDirectory.path}/$fileName');
    await target.writeAsBytes(bytes, flush: true);
    return target.path;
  }

  /// 判断已记录的皮肤文件是否仍然存在。
  Future<bool> exists(String path) => File(path).exists();

  /// 删除不再使用的皮肤文件。
  Future<void> delete(String path) async {
    final File file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
