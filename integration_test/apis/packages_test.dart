import 'package:flutter_test/flutter_test.dart';

import 'support/api_test_support.dart';

late final ApiTestClient _client;

void main() {
  _client = ApiTestClient(
    baseUrl: ApiTestConfig.unit3BaseUrl,
    headers: ApiTestConfig.unit3Headers,
  );

  group('插件包、分类、评论与反馈接口', () {
    test('GET /packages 获取全部插件包', _testPackages);
    test('GET /categories 获取分类列表', _testCategories);
    test(
      'GET /categories/{key}/export 获取分类插件',
      _testCategoryPackages,
      skip: _categoryKeySkipReason(),
    );
    test(
      'GET /packages/{id}/comments 获取评论',
      _testPackageComments,
      skip: _packageIdSkipReason(),
    );
    test(
      'GET /comments/{id}/replies 获取回复',
      _testCommentReplies,
      skip: skipWithoutPositiveInt(
        'API_TEST_COMMENT_ID',
        ApiTestConfig.commentId,
      ),
    );
    test(
      'POST /packages/import 导入插件',
      _testImportPackage,
      skip: skipWriteTest(_packageNameSkipReason()),
    );
    test(
      'DELETE /packages/{name} 删除插件',
      _testDeletePackage,
      skip: skipWriteTest(_packageNameSkipReason()),
    );
    test(
      'POST /categories 新增分类',
      _testCreateCategory,
      skip: skipWriteTest(_categoryKeySkipReason()),
    );
    test(
      'POST /packages/add_to_category 添加插件到分类',
      _testAddPackageToCategory,
      skip: skipWriteTest(_packageAndCategorySkipReason()),
    );
    test(
      'POST /packages/{id}/comments 发表评论',
      _testSendComment,
      skip: skipWriteTest(_packageIdSkipReason()),
    );
    test(
      'POST /feedback 提交反馈',
      _testFeedback,
      skip: skipWriteTest(),
    );
  });
}

String? _categoryKeySkipReason() {
  return skipWithoutString(
    'API_TEST_CATEGORY_KEY',
    ApiTestConfig.categoryKey,
  );
}

String? _packageIdSkipReason() {
  return skipWithoutPositiveInt(
    'API_TEST_PACKAGE_ID',
    ApiTestConfig.packageId,
  );
}

String? _packageNameSkipReason() {
  return skipWithoutString(
    'API_TEST_PACKAGE_NAME',
    ApiTestConfig.packageName,
  );
}

String? _packageAndCategorySkipReason() {
  return _packageNameSkipReason() ?? _categoryKeySkipReason();
}

Future<void> _testPackages() async {
  dynamic body = await _client.request('/packages');
  expect(body, isNotNull);
}

Future<void> _testCategories() async {
  Map<String, dynamic> body = expectJsonMap(
    await _client.request(
      '/categories',
      query: <String, int>{'page': 1, 'page_size': 100},
    ),
  );
  List<dynamic> categories = expectJsonList(body['data']);
  for (dynamic item in categories) {
    Map<String, dynamic> category = expectJsonMap(item);
    expect(
      category.keys,
      containsAll(<String>['id', 'key', 'name', 'description']),
    );
  }
}

Future<void> _testCategoryPackages() async {
  Map<String, dynamic> body = expectJsonMap(
    await _client.request(
      '/categories/${ApiTestConfig.categoryKey}/export',
      query: <String, dynamic>{
        'sort_by': 'downloads',
        'page': 1,
        'page_size': 5,
      },
    ),
  );
  List<dynamic> packages = expectJsonList(body['data']);
  for (dynamic item in packages) {
    _expectPackage(item);
  }
}

Future<void> _testPackageComments() async {
  Map<String, dynamic> body = expectJsonMap(
    await _client.request(
      '/packages/${ApiTestConfig.packageId}/comments',
      query: <String, int>{'page': 1, 'page_size': 10},
    ),
  );
  expect(body['total'], isA<int>());
  for (dynamic item in expectJsonList(body['data'])) {
    _expectComment(item);
  }
}

Future<void> _testCommentReplies() async {
  Map<String, dynamic> body = expectJsonMap(
    await _client.request(
      '/comments/${ApiTestConfig.commentId}/replies',
      query: <String, int>{'page': 1, 'page_size': 15},
    ),
  );
  for (dynamic item in expectJsonList(body['data'])) {
    _expectComment(item);
  }
}

Future<void> _testImportPackage() async {
  dynamic body = await _client.request(
    '/packages/import',
    method: 'POST',
    data: _testPackagePayload(),
  );
  expect(body, isNotNull);
}

Future<void> _testDeletePackage() async {
  dynamic body = await _client.request(
    '/packages/${Uri.encodeComponent(ApiTestConfig.packageName)}',
    method: 'DELETE',
  );
  expect(body, isNotNull);
}

Future<void> _testCreateCategory() async {
  dynamic body = await _client.request(
    '/categories',
    method: 'POST',
    data: <String, String>{
      'key': ApiTestConfig.categoryKey,
      'name': 'FlutterUnit 集成测试分类',
      'description': '服务迁移契约验证',
    },
  );
  expect(body, isNotNull);
}

Future<void> _testAddPackageToCategory() async {
  dynamic body = await _client.request(
    '/packages/add_to_category',
    method: 'POST',
    data: <String, dynamic>{
      'category_key': ApiTestConfig.categoryKey,
      'package_names': <String>[ApiTestConfig.packageName],
    },
  );
  expect(body, isNotNull);
}

Future<void> _testSendComment() async {
  dynamic body = await _client.request(
    '/packages/${ApiTestConfig.packageId}/comments',
    method: 'POST',
    data: <String, String>{
      'content': 'FlutterUnit 服务迁移集成测试评论',
      'guest_name': '集成测试',
    },
  );
  expect(body, isNotNull);
}

Future<void> _testFeedback() async {
  dynamic body = await _client.request(
    '/feedback',
    method: 'POST',
    data: <String, String>{
      'feedback_type': 'integration_test',
      'title': 'FlutterUnit 服务迁移测试',
      'content': '该数据由接口集成测试生成，可以安全删除。',
    },
  );
  expect(body, isNotNull);
}

Map<String, dynamic> _testPackagePayload() {
  return <String, dynamic>{
    'name': ApiTestConfig.packageName,
    'last_version': '0.0.1-integration-test',
    'last_publish': DateTime.now().toUtc().toIso8601String(),
    'statistics': <String, int>{'likes': 0, 'points': 0, 'downloads': 0},
    'tags': <String>['integration-test'],
    'desc': 'FlutterUnit 服务迁移集成测试数据',
    'publisher': 'FlutterUnit',
    'topics': <String>['integration-test'],
    'dependencies': <String, dynamic>{},
  };
}

void _expectPackage(dynamic value) {
  Map<String, dynamic> package = expectJsonMap(value);
  expect(
      package.keys,
      containsAll(<String>[
        'id',
        'name',
        'last_version',
        'last_publish',
        'statistics',
        'tags',
      ]));
}

void _expectComment(dynamic value) {
  Map<String, dynamic> comment = expectJsonMap(value);
  expect(
      comment.keys,
      containsAll(<String>[
        'id',
        'package_id',
        'guest_name',
        'content',
        'content_type',
        'create_at',
        'replies_total',
      ]));
}
