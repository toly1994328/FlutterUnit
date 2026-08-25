import 'package:flutter_test/flutter_test.dart';

import 'support/api_test_support.dart';

late final ApiTestClient _client;

void main() {
  _client = ApiTestClient(
    baseUrl: ApiTestConfig.scienceBaseUrl,
    headers: ApiTestConfig.scienceHeaders,
  );

  group('升级与事件接口', () {
    test('GET /app_version 查询版本', _testAppVersion);
    test(
      'POST /event 上报事件',
      _testEvent,
      skip: skipWriteTest(),
    );
  });
}

Future<void> _testAppVersion() async {
  dynamic body = await _client.request(
    '/app_version',
    query: <String, dynamic>{
      'app_id': 1,
      'os': ApiTestConfig.platform,
      'locale': 'zh_CN',
    },
  );
  Map<String, dynamic> data = expectJsonMap(unwrapScienceResponse(body));
  expect(data.keys, containsAll(<String>['version', 'url', 'size']));
  expect(data['version'], isA<String>());
  expect(data['url'], isA<String>());
  expect(data['size'], isA<int>());
}

Future<void> _testEvent() async {
  dynamic body = await _client.request(
    '/event',
    method: 'POST',
    data: <String, int>{'event': 1},
  );
  expect(unwrapScienceResponse(body), isA<bool>());
}
