import 'dart:typed_data';

/// 非本机平台的用户皮肤文件存储占位实现。
class UserSkinFileStore {
  /// 当前平台不支持持久化本机皮肤文件。
  Future<String> save(
    String fileName,
    Uint8List bytes,
  ) {
    throw UnsupportedError('当前平台暂不支持自定义本机皮肤');
  }

  /// 非本机平台不存在可读取的皮肤文件。
  Future<bool> exists(String path) async => false;

  /// 非本机平台无需删除皮肤文件。
  Future<void> delete(String path) async {}
}
