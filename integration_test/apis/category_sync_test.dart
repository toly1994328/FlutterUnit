import 'package:flutter_test/flutter_test.dart';

import 'support/api_test_support.dart';

late final ApiTestClient _client;

void main() {
  _client = ApiTestClient(
    baseUrl: ApiTestConfig.legacyBaseUrl,
    headers: legacyHeaders(),
  );

  group('分类与收藏同步接口', () {
    test(
      'GET /categoryData 获取云端数据',
      _testGetCategoryData,
      skip: skipWithoutString('API_TEST_TOKEN', ApiTestConfig.token),
    );
    test(
      'POST /categoryData/sync 上传云端数据',
      _testUploadCategoryData,
      skip: skipWriteTest(
        skipWithoutString('API_TEST_TOKEN', ApiTestConfig.token),
      ),
    );
  });
}

Future<void> _testGetCategoryData() async {
  Map<String, dynamic> body = expectJsonMap(
    await _client.request('/categoryData'),
  );
  expect(body['status'], true);
  if (body['data'] == null) return;
  Map<String, dynamic> data = expectJsonMap(body['data']);
  expect(
      data.keys,
      containsAll(<String>[
        'categoryDataId',
        'userId',
        'data',
        'likeData',
      ]));
}

Future<void> _testUploadCategoryData() async {
  Map<String, dynamic> body = expectJsonMap(
    await _client.request(
      '/categoryData/sync',
      method: 'POST',
      data: <String, String>{
        'data': '[]',
        'likeData': '[]',
      },
    ),
  );
  expect(body['status'], isA<bool>());
}
