import 'package:flutter_test/flutter_test.dart';

import 'support/api_test_support.dart';

late final ApiTestClient _client;

void main() {
  _client = ApiTestClient(baseUrl: ApiTestConfig.legacyBaseUrl);

  group('认证与账户接口', () {
    test(
      'POST /login 用户名密码登录',
      _testLogin,
      skip: _loginSkipReason(),
    );
    test(
      'POST /register 邮箱注册',
      _testRegister,
      skip: skipWriteTest(_registerSkipReason()),
    );
    test(
      'POST /sendEmail/{email} 发送验证码',
      _testSendEmail,
      skip: skipWriteTest(
        skipWithoutString('API_TEST_EMAIL', ApiTestConfig.email),
      ),
    );
  });
}

String? _loginSkipReason() {
  String? usernameReason = skipWithoutString(
    'API_TEST_USERNAME',
    ApiTestConfig.username,
  );
  return usernameReason ??
      skipWithoutString('API_TEST_PASSWORD', ApiTestConfig.password);
}

String? _registerSkipReason() {
  String? emailReason = skipWithoutString(
    'API_TEST_EMAIL',
    ApiTestConfig.email,
  );
  return emailReason ??
      skipWithoutString('API_TEST_ACTIVE_CODE', ApiTestConfig.activeCode);
}

Future<void> _testLogin() async {
  dynamic body = await _client.request(
    '/login',
    method: 'POST',
    data: <String, String>{
      'username': ApiTestConfig.username,
      'password': ApiTestConfig.password,
    },
  );
  Map<String, dynamic> envelope = expectJsonMap(body);
  expect(envelope['status'], true);
  expect(envelope['msg'], isA<String>());
  Map<String, dynamic> user = expectJsonMap(envelope['data']);
  expect(
      user.keys,
      containsAll(<String>[
        'username',
        'userAvatar',
        'email',
        'roles',
        'userId',
      ]));
}

Future<void> _testRegister() async {
  dynamic body = await _client.request(
    '/register',
    method: 'POST',
    data: <String, String>{
      'email': ApiTestConfig.email,
      'activeCode': ApiTestConfig.activeCode,
    },
  );
  expect(body, isNotNull);
}

Future<void> _testSendEmail() async {
  dynamic body = await _client.request(
    '/sendEmail/${Uri.encodeComponent(ApiTestConfig.email)}',
    method: 'POST',
  );
  Map<String, dynamic> envelope = expectJsonMap(body);
  expect(envelope['status'], isA<bool>());
  expect(envelope['msg'], isA<String>());
}
