import 'dart:convert';
import 'dart:typed_data';

import 'package:app/http/flutter_unit/flutter_unit_response_interceptor.dart';
import 'package:authentication/runtime/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fx_user_http/fx_user_http.dart';
import 'package:unit_env/unit_env.dart';

void main() {
  for (final int status in <int>[400, 401, 403, 422, 429, 500, 502]) {
    test('修改密码 HTTP $status 必须返回失败', () => _rejectPasswordFailure(status));
  }
  test('只有服务端成功响应才能提示密码已修改', _acceptPasswordSuccess);
  test('HTTP 200 业务失败仍然返回失败', _rejectBusinessFailure);
  test('非 JSON 错误响应不会误报密码修改成功', _rejectProxyFailure);
  test('兼容旧版布尔状态响应', _legacyResponse);
  test('旧版布尔失败状态也不会误报成功', _legacyFailure);
  test('保留分页内容', _paginatedResponse);
  test('应用仓储向页面传递旧密码错误原因', _passwordErrorMessage);
  test('应用仓储不会把代理 HTML 当成错误提示', _passwordProxyMessage);
  test('应用仓储仅在服务端确认后返回成功', _applicationPasswordSuccess);
}

Future<void> _passwordErrorMessage() async {
  final _Fixture fixture = _Fixture(401, <String, dynamic>{
    'code': 'UNAUTHORIZED',
    'message': '旧密码错误',
  });
  addTearDown(fixture.close);
  final FlutterUnitUserRepository users =
      FlutterUnitUserRepository(host: fixture.host);
  await expectLater(
    users.changePassword(oldPassword: 'test-old', newPassword: 'test-new'),
    throwsA(isA<RequestException>()
        .having((RequestException error) => error.message, 'message', '旧密码错误')
        .having((RequestException error) => error.httpStatus, 'status', 401)
        .having((RequestException error) => error.serverCode, 'code',
            'UNAUTHORIZED')
        .having((RequestException error) => error.error, '无密码请求数据', isNull)),
  );
}

Future<void> _passwordProxyMessage() async {
  final _Fixture fixture = _Fixture(502, '<html>Bad Gateway</html>');
  addTearDown(fixture.close);
  final FlutterUnitUserRepository users =
      FlutterUnitUserRepository(host: fixture.host);
  await expectLater(
    users.changePassword(oldPassword: 'test-old', newPassword: 'test-new'),
    throwsA(isA<RequestException>()
        .having((RequestException error) => error.message, 'message', isNull)),
  );
}

Future<void> _applicationPasswordSuccess() async {
  final _Fixture fixture = _Fixture(200, <String, dynamic>{
    'code': 'SUCCESS',
    'data': null,
  });
  addTearDown(fixture.close);
  final FlutterUnitUserRepository users =
      FlutterUnitUserRepository(host: fixture.host);
  expect(
      await users.changePassword(
          oldPassword: 'test-old', newPassword: 'test-new'),
      isTrue);
}

Future<void> _rejectPasswordFailure(int status) async {
  final _Fixture fixture = _Fixture(status, <String, dynamic>{
    'code': status == 401 ? 'UNAUTHORIZED' : 'BAD_REQUEST',
    'message': '密码操作失败',
  });
  addTearDown(fixture.close);
  final bool changed = await fixture.users
      .changePassword(oldPassword: 'test-old', newPassword: 'test-new');
  expect(changed, isFalse);
}

Future<void> _acceptPasswordSuccess() async {
  final _Fixture fixture = _Fixture(200, <String, dynamic>{
    'code': 'SUCCESS',
    'message': '密码修改成功',
    'data': null,
  });
  addTearDown(fixture.close);
  expect(
      await fixture.users
          .changePassword(oldPassword: 'test-old', newPassword: 'test-new'),
      isTrue);
}

Future<void> _rejectBusinessFailure() async {
  final _Fixture fixture = _Fixture(200, <String, dynamic>{
    'code': 'PASSWORD_INVALID',
    'message': '旧密码错误',
  });
  addTearDown(fixture.close);
  expect(await fixture.users.setPassword('test-new'), isFalse);
}

Future<void> _rejectProxyFailure() async {
  final _Fixture fixture = _Fixture(502, '<html>Bad Gateway</html>');
  addTearDown(fixture.close);
  expect(await fixture.users.setPassword('test-new'), isFalse);
}

Future<void> _legacyFailure() async {
  final _Fixture fixture =
      _Fixture(200, <String, dynamic>{'status': false, 'msg': '操作失败'});
  addTearDown(fixture.close);
  expect(await fixture.users.setPassword('test-new'), isFalse);
}

Future<void> _legacyResponse() async {
  final _Fixture fixture = _Fixture(200, <String, dynamic>{
    'status': true,
    'data': <String, dynamic>{'value': 1}
  });
  addTearDown(fixture.close);
  final Response<dynamic> response = await fixture.dio.get<dynamic>('/probe');
  expect(response.data, <String, dynamic>{
    'status': true,
    'data': <String, dynamic>{'value': 1}
  });
}

Future<void> _paginatedResponse() async {
  final _Fixture fixture = _Fixture(200, <String, dynamic>{
    'code': 'SUCCESS',
    'data': <int>[1, 2],
    'paginate': <String, dynamic>{'total': 2},
  });
  addTearDown(fixture.close);
  final Response<dynamic> response = await fixture.dio.get<dynamic>('/probe');
  expect(response.data, <String, dynamic>{
    'data': <int>[1, 2],
    'paginate': <String, dynamic>{'total': 2}
  });
}

/// 使用实际 SDK 和宿主拦截器验证完整响应链，所有 HTTP 请求留在内存中。
class _Fixture {
  _Fixture(int status, Object body) {
    FxDio().register(host,
        options: HostOptions(
            enableLog: false,
            repInterceptor: FlutterUnitResponseInterceptor()));
    dio = FxDio()[host];
    dio.httpClientAdapter = _Adapter(status, body);
    users = HttpFxUserRepository(host: host);
  }

  /// 测试专用请求宿主。
  final FlutterUnitHost host = const FlutterUnitHost();

  /// 注册了生产响应拦截器的请求客户端。
  late final Dio dio;

  /// 实际使用的用户接口 SDK。
  late final HttpFxUserRepository users;

  void close() => FxDio().unregister(host);
}

class _Adapter implements HttpClientAdapter {
  _Adapter(this.status, this.body);

  /// 预设 HTTP 状态码。
  final int status;

  /// 预设响应体，始终使用测试内容。
  final Object body;

  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<Uint8List>? requestStream, Future<void>? cancelFuture) async {
    return ResponseBody.fromString(
        body is String ? body as String : jsonEncode(body), status,
        headers: <String, List<String>>{
          'content-type': <String>[
            body is String ? 'text/html' : 'application/json'
          ]
        });
  }

  @override
  void close({bool force = false}) {}
}
