import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:pkg_player/pkg_player.dart';
import 'package:unit_env/unit_env.dart';

import 'moke/moke.dart';

void main() async {
  PackageRequest request = PackageRequest();
  String mockDir = p.join(
    Directory.current.path,
    'test',
    'science_server',
    'moke',
  );

  setUpAll(() async {
    FxDio().register(Unit3Host());
  });

  Future<void> getAllPackages() async {
    ApiRet<dynamic> ret = await request.getAllPackages();
    if (ret.success) {
      print(ret.data);
    }
  }

  Future<void> getInsertPackages() async {
    ApiRet<dynamic> ret = await request.insertPackage(data);
    if (ret.success) {
      print(ret.data);
    }
  }

  Future<void> deletePackages() async {
    ApiRet<dynamic> ret = await request.deletePackages('provider');
    if (ret.success) {
      print(ret.data);
    }
  }

  Future<void> addCategories() async {
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

  Future<void> getCategories() async {
    File file = File(p.join(mockDir, 'api_category.json'));
    ApiRet<dynamic> ret = await request.getCategories();
    if (ret.success) {
      String formattedJson =
          const JsonEncoder.withIndent('  ').convert(ret.data);
      await file.writeAsString(formattedJson);
      print('Categories saved to ${file.path}');
    }
  }

  Future<void> getCategoriesPackage() async {
    File file = File(p.join(mockDir, 'api_category_packages.json'));
    ApiRet<dynamic> ret =
        await request.getCategoriesPackage(key: 'state_management');
    if (ret.success) {
      String formattedJson =
          const JsonEncoder.withIndent('  ').convert(ret.data);
      await file.writeAsString(formattedJson);
      print('Categories saved to ${file.path}');
    }
  }

  group('System API Tests', () {
    test('/packages', getAllPackages);
    test('/insert', getInsertPackages);
    test('/delete', deletePackages);
    test('addCategories', addCategories);
    test('getCategories', getCategories);
    test('getCategoriesPackages', getCategoriesPackage);
  });
}
