import 'package:flutter_test/flutter_test.dart';

import 'support/api_test_support.dart';

late final ApiTestClient _client;

void main() {
  _client = ApiTestClient(
    baseUrl: ApiTestConfig.scienceBaseUrl,
    headers: ApiTestConfig.scienceHeaders,
  );

  group('文章与笔记接口', () {
    test('GET /article 分页查询文章', _testListArticles);
    test('GET /category 获取文章分类树', _testCategoryTree);
    test(
      'GET /article/open/{id} 打开文章',
      _testOpenArticle,
      skip: _articleIdSkipReason(),
    );
    test(
      'GET /article/tag 按标签查询文章',
      _testArticlesByTag,
      skip: skipWithoutPositiveInt(
        'API_TEST_ARTICLE_TAG_ID',
        ApiTestConfig.articleTagId,
      ),
    );
    test('POST /article 创建文章', _testCreateArticle, skip: skipWriteTest());
    test(
      'POST /article/write 写入文章内容',
      _testWriteArticle,
      skip: skipWriteTest(_articleIdSkipReason()),
    );
    test(
      'PUT /article/{id} 更新文章',
      _testUpdateArticle,
      skip: skipWriteTest(_articleIdSkipReason()),
    );
    test(
      'DELETE /article/{id} 删除文章',
      _testDeleteArticle,
      skip: skipWriteTest(_articleIdSkipReason()),
    );
  });
}

String? _articleIdSkipReason() {
  return skipWithoutPositiveInt(
    'API_TEST_ARTICLE_ID',
    ApiTestConfig.articleId,
  );
}

Future<void> _testListArticles() async {
  dynamic body = await _client.request(
    '/article',
    query: <String, int>{'page': 1, 'page_size': 5},
  );
  List<dynamic> articles = expectJsonList(unwrapScienceResponse(body));
  for (dynamic item in articles) {
    _expectArticle(item);
  }
}

Future<void> _testCategoryTree() async {
  dynamic body = await _client.request('/category');
  dynamic data = unwrapScienceResponse(body);
  Map<String, dynamic> wrapper = expectJsonMap(data);
  Map<String, dynamic> root = expectJsonMap(wrapper['data']);
  _expectCategory(root);
}

Future<void> _testOpenArticle() async {
  dynamic body = await _client.request(
    '/article/open/${ApiTestConfig.articleId}',
  );
  expect(unwrapScienceResponse(body), isA<String>());
}

Future<void> _testArticlesByTag() async {
  dynamic body = await _client.request(
    '/article/tag',
    query: <String, int>{
      'tag_id': ApiTestConfig.articleTagId,
      'page': 1,
      'page_size': 5,
    },
  );
  List<dynamic> articles = expectJsonList(unwrapScienceResponse(body));
  for (dynamic item in articles) {
    _expectArticle(item);
  }
}

Future<void> _testCreateArticle() async {
  dynamic body = await _client.request(
    '/article',
    method: 'POST',
    data: <String, dynamic>{
      'title': 'FlutterUnit 集成测试文章',
      'create_at': DateTime.now().toUtc().toIso8601String(),
      'subtitle': '服务迁移契约验证',
      'url': '/integration-test',
      'type': 1,
      'cover': '',
    },
  );
  dynamic data = unwrapScienceResponse(body);
  expect(data, isNotNull);
}

Future<void> _testWriteArticle() async {
  dynamic body = await _client.request(
    '/article/write',
    method: 'POST',
    data: <String, dynamic>{
      'article_id': ApiTestConfig.articleId,
      'content': 'FlutterUnit integration test',
    },
  );
  expect(unwrapScienceResponse(body), isA<bool>());
}

Future<void> _testUpdateArticle() async {
  dynamic body = await _client.request(
    '/article/${ApiTestConfig.articleId}',
    method: 'PUT',
    data: <String, String>{
      'title': 'FlutterUnit 集成测试文章（已更新）',
    },
  );
  _expectArticle(unwrapScienceResponse(body));
}

Future<void> _testDeleteArticle() async {
  dynamic body = await _client.request(
    '/article/${ApiTestConfig.articleId}',
    method: 'DELETE',
  );
  dynamic data = unwrapScienceResponse(body);
  expect(data, anyOf(isA<bool>(), isA<Map<String, dynamic>>()));
}

void _expectArticle(dynamic value) {
  Map<String, dynamic> article = expectJsonMap(value);
  expect(
      article.keys,
      containsAll(<String>[
        'article_id',
        'title',
        'type',
        'status',
        'create_at',
        'update_at',
        'url',
      ]));
}

void _expectCategory(Map<String, dynamic> category) {
  expect(category.keys, containsAll(<String>['cate_id', 'name']));
  dynamic children = category['children'];
  if (children == null) return;
  for (dynamic child in expectJsonList(children)) {
    _expectCategory(expectJsonMap(child));
  }
}
