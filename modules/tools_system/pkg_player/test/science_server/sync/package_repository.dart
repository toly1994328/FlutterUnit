import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:pkg_player/pkg_player.dart';

import 'pub_repository.dart';

abstract class PackageRepository {
  Future<PluginModel> syncPackage(String name);

  Future<List<PluginModel>> syncPackages(List<String> packageNames,
      {int batchSize = 5});

  Future<void> createPackageFiles( String fileDir,List<dynamic> jsonData);
}

class PubPackageRepository extends PackageRepository {
  PubRepository _repo = PubRepository();

  @override
  Future<PluginModel> syncPackage(String name) async {
    List<dynamic> results = await Future.wait([
      _repo.getPackageDetail(name),
      _repo.getPackageMetrics(name),
    ]);

    dynamic detail = results[0];
    dynamic ret1 = results[1];
    dynamic latest = detail['latest'];
    dynamic pubspec = latest['pubspec'];
    List<dynamic> tags = ret1['score']['tags'];
    String? publisher;

    for (String value in tags) {
      if (value.startsWith('publisher:')) {
        publisher = value.replaceAll('publisher:', '');
        break;
      }
    }
    return PluginModel.fromJson({
      "name": detail['name'],
      "last_version": latest['version'],
      "last_publish": latest['published'],
      "statistics": {
        "likes": ret1['score']['likeCount'],
        "points": ret1['score']['grantedPoints'],
        "downloads": ret1['score']['downloadCount30Days'],
      },
      "tags": ret1['score']['tags'],
      "desc": pubspec['description'],
      "publisher": publisher,
      "repository": pubspec['repository'],
      "homepage": pubspec['homepage'],
      "dependencies": pubspec['dependencies'],
      "topics": pubspec['topics']
    });
  }

  @override
  Future<List<PluginModel>> syncPackages(List<String> packageNames,
      {int batchSize = 5}) async {
    List<PluginModel> results = [];

    for (int i = 0; i < packageNames.length; i += batchSize) {
      int end = (i + batchSize < packageNames.length)
          ? i + batchSize
          : packageNames.length;
      List<String> batch = packageNames.sublist(i, end);

      List<Future<PluginModel?>> futures = batch.map((name) async {
        try {
          return await syncPackage(name);
        } catch (e) {
          print('Failed to sync package $name: $e');
          return null;
        }
      }).toList();

      List<PluginModel?> batchResults = await Future.wait(futures);
      results.addAll(
          batchResults.where((model) => model != null).cast<PluginModel>());
    }

    return results;
  }

  //{
  //     "category": "ui",
  //     "packages": [
  //       "macos_ui",
  //       "fluent_ui",
  //       "tolyui",
  //     ]
  //   }
  @override
  Future<void> createPackageFiles(
      String fileDir, List<dynamic> jsonData) async {
    for (dynamic e in jsonData) {
      File outFile = File(p.join(fileDir, e['category']+".json"));
      List<PluginModel> pkgs = [];
      for (dynamic pkg in e['packages']) {
        pkgs.add(await syncPackage(pkg));
        print("SYNC SUCCESS $pkg");
      }
      String formattedJson = const JsonEncoder.withIndent('  ').convert(pkgs);
      await outFile.writeAsString(formattedJson);
    }
    return;
  }
}
