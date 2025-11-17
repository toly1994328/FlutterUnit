import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:pkg_player/pkg_player.dart';

import 'sync/package_repository.dart';

void main() {
  String mockDir = p.join(
    Directory.current.path,
    'test',
    'science_server',
    'moke',
  );
  PackageRequest request = PackageRequest();

  group('sync package', () {
    late PackageRepository repository;
    setUp(() {
      repository = PubPackageRepository();
      FxDio().register(ScienceHost());
    });

    /// 插入所有的分类
    Future<void> insertAllCategories() async {
      File file = File(p.join(mockDir, 'category.json'));
      String data = await file.readAsString();
      List<dynamic> jsonData = jsonDecode(data);
      for (dynamic e in jsonData) {
        ApiRet<dynamic> ret = await request.addCategoriesRaw(e);
        if (ret.success) {
          print(ret.data);
        }
      }
    }

    /// 插入所有的分类-包映射
    Future<void> handleCategoryPackage() async {
      File file = File(p.join(mockDir, 'cate_pkgs.json'));
      Directory outputDir =
          Directory(p.join(mockDir, 'output', 'category_packages'));
      if (!outputDir.existsSync()) {
        outputDir.createSync(recursive: true);
      }
      String data = await file.readAsString();
      List<dynamic> jsonData = jsonDecode(data);
      await repository.createPackageFiles(outputDir.path, jsonData);
    }

    /// 插入把分类-包映射 通过接口插入远程数据库
    Future<void> syncToServer() async {
      Directory outputDir =
          Directory(p.join(mockDir, 'output', 'category_packages'));
      if (!outputDir.existsSync()) {
        return;
      }
      List<FileSystemEntity> entities = outputDir.listSync();
      for (FileSystemEntity file in entities) {
        if (file is File) {
          String data = await file.readAsString();
          List<dynamic> jsonData = jsonDecode(data);
          String category =  p.basenameWithoutExtension(file.path);
          await request.insertPackages(
              category, jsonData);
          print('同步成功:$category');
        }
      }
    }

    test('insertAllCategories', insertAllCategories);
    test('handleCategoryPackage', handleCategoryPackage);
    test('syncToServer', syncToServer);
  });
}
