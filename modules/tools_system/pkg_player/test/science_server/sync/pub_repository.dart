import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model/pub_package.dart';

class PubRepository {
  static const String _baseUrl = 'https://pub.dev/api';
  final http.Client _client;

  PubRepository({http.Client? client}) : _client = client ?? http.Client();

  /// 搜索包
  Future<SearchResult> searchPackages({
    required String query,
    int page = 1,
    String? sort,
  }) async {
    final uri = Uri.parse('$_baseUrl/search').replace(queryParameters: {
      'q': query,
      'page': page.toString(),
      if (sort != null) 'sort': sort,
    });

    final response = await _client.get(uri);
    if (response.statusCode == 200) {
      return SearchResult.fromJson(json.decode(response.body));
    }
    throw Exception('Failed to search packages: ${response.statusCode}');
  }

  /// 获取包详情
  Future<PubPackage> getPackage(String packageName) async {
    final response =
        await _client.get(Uri.parse('$_baseUrl/packages/$packageName'));
    if (response.statusCode == 200) {
      return PubPackage.fromJson(json.decode(response.body));
    }
    throw Exception('Failed to get package: ${response.statusCode}');
  }

  /// 获取包详细信息（包含依赖等）
  Future<dynamic> getPackageDetail(String packageName) async {
    final response =
        await _client.get(Uri.parse('$_baseUrl/packages/$packageName'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to get package detail: ${response.statusCode}');
  }

  /// 获取包的所有版本
  Future<List<PackageVersion>> getPackageVersions(String packageName) async {
    final response = await _client
        .get(Uri.parse('$_baseUrl/packages/$packageName/versions'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['versions'] as List)
          .map((v) => PackageVersion.fromJson(v))
          .toList();
    }
    throw Exception('Failed to get package versions: ${response.statusCode}');
  }

  /// 获取特定版本信息
  Future<PackageVersion> getPackageVersion(
      String packageName, String version) async {
    final response = await _client
        .get(Uri.parse('$_baseUrl/packages/$packageName/versions/$version'));
    if (response.statusCode == 200) {
      return PackageVersion.fromJson(json.decode(response.body));
    }
    throw Exception('Failed to get package version: ${response.statusCode}');
  }

  /// 获取包评分
  Future<PackageScore> getPackageScore(String packageName) async {
    final response =
        await _client.get(Uri.parse('$_baseUrl/packages/$packageName/score'));
    if (response.statusCode == 200) {
      return PackageScore.fromJson(json.decode(response.body));
    }
    throw Exception('Failed to get package score: ${response.statusCode}');
  }

  /// 获取包的指标数据
  Future<dynamic> getPackageMetrics(String packageName) async {
    final response =
        await _client.get(Uri.parse('$_baseUrl/packages/$packageName/metrics'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to get package metrics: ${response.statusCode}');
  }

  /// 获取包的发布者信息
  Future<Map<String, dynamic>> getPackagePublisher(String packageName) async {
    final response = await _client
        .get(Uri.parse('$_baseUrl/packages/$packageName/publisher'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to get package publisher: ${response.statusCode}');
  }

  /// 获取热门包列表
  Future<List<PubPackage>> getPopularPackages({int limit = 10}) async {
    final result = await searchPackages(
      query: '',
      sort: 'popularity',
    );
    return result.packages.take(limit).toList();
  }

  /// 获取最新包列表
  Future<List<PubPackage>> getLatestPackages({int limit = 10}) async {
    final result = await searchPackages(
      query: '',
      sort: 'updated',
    );
    return result.packages.take(limit).toList();
  }

  /// 按标签搜索
  Future<SearchResult> searchByTag(String tag, {int page = 1}) async {
    return searchPackages(query: 'tags:$tag', page: page);
  }

  /// 按依赖搜索
  Future<SearchResult> searchByDependency(String dependency,
      {int page = 1}) async {
    return searchPackages(query: 'dependency:$dependency', page: page);
  }

  void dispose() {
    _client.close();
  }
}
