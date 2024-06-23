import 'dart:io';

import 'package:path/path.dart' as path;

void main() async {
  Directory distDir =
      Directory(path.join(Directory.current.path, '.dart_tool', 'flutter_gen', 'gen_l10n'));
  if (!distDir.existsSync()) return;

  Directory srcDir = Directory(path.join(Directory.current.path, 'lib', 'gen_l10n'));
  if (srcDir.existsSync()) {
    await srcDir.delete(recursive: true);
  } else {
    await srcDir.create(recursive: true);
  }
  List<FileSystemEntity> entity = distDir.listSync();
  for (FileSystemEntity e in entity) {
    if (e is File) {
      e.copy(path.join(srcDir.path, path.basename(e.path)));
    }
  }
}
