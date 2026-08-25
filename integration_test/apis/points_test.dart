import 'package:flutter_test/flutter_test.dart';

import 'support/api_test_support.dart';

late final ApiTestClient _client;

void main() {
  _client = ApiTestClient(baseUrl: ApiTestConfig.unitBaseUrl);

  group('FlutterUnit 仓库与知识点接口', () {
    test('GET /repository/name/FlutterUnit 获取仓库信息', _testRepository);
    test('GET /point 获取知识点列表', _testPoints);
    test(
      'GET /pointComment/{pointId} 获取知识点评论',
      _testPointComments,
      skip: skipWithoutPositiveInt(
        'API_TEST_POINT_ID',
        ApiTestConfig.pointId,
      ),
    );
  });
}

Future<void> _testRepository() async {
  Map<String, dynamic> body = expectJsonMap(
    await _client.request('/repository/name/FlutterUnit'),
  );
  Map<String, dynamic> data = expectJsonMap(body['data']);
  expect(data['repositoryData'], isA<String>());
}

Future<void> _testPoints() async {
  Map<String, dynamic> body = expectJsonMap(
    await _client.request(
      '/point',
      query: <String, int>{'page': 1, 'pageSize': 5},
    ),
  );
  List<dynamic> data = expectJsonList(body['data']);
  for (dynamic item in data) {
    Map<String, dynamic> point = expectJsonMap(item);
    expect(point['pointData'], isA<String>());
  }
}

Future<void> _testPointComments() async {
  Map<String, dynamic> body = expectJsonMap(
    await _client.request('/pointComment/${ApiTestConfig.pointId}'),
  );
  List<dynamic> data = expectJsonList(body['data']);
  for (dynamic item in data) {
    Map<String, dynamic> comment = expectJsonMap(item);
    expect(comment['pointCommentData'], isA<String>());
  }
}
