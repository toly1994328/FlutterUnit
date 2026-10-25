import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:app/http/flutter_unit/flutter_unit_response_interceptor.dart';
import 'package:authentication/runtime/session_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fx_user_core/fx_user_core.dart';
import 'package:fx_user_http/fx_user_http.dart';
import 'package:fx_user_session/fx_user_session.dart';
import 'package:unit_env/unit_env.dart';

void main() {
  test('旧密码错误但资料查询成功时，不退出当前账号', _keepValidSession);
  test('资料查询也返回 401 时才清理当前会话', _clearInvalidSession);
  test('资料接口暂时故障不会清理会话', _keepSessionOnServerFailure);
  test('验证会话时断网不会清理会话', _keepSessionOnNetworkFailure);
  test('旧凭据的迟到 401 不影响新会话', _ignoreStaleFailure);
  test('资料接口 401 直接清理，避免循环验证', _profileFailure);
}

Future<void> _keepValidSession() async {
  final _Fixture fixture = _Fixture(profileStatus: 200);
  addTearDown(fixture.close);
  expect(await fixture.changePassword(), isFalse);
  await fixture.profileSeen.future.timeout(const Duration(seconds: 1));
  expect(fixture.session.invalidations, 0);
  expect(fixture.session.state, isA<FxAuthed>());
}

Future<void> _clearInvalidSession() async {
  final _Fixture fixture = _Fixture(profileStatus: 401);
  addTearDown(fixture.close);
  expect(await fixture.changePassword(), isFalse);
  await fixture.session.invalidated.future.timeout(const Duration(seconds: 1));
  expect(fixture.session.invalidations, 1);
  expect(fixture.session.state, isA<FxGuest>());
  expect(fixture.adapter.requests, 2);
}

Future<void> _keepSessionOnServerFailure() async {
  final _Fixture fixture = _Fixture(profileStatus: 503);
  addTearDown(fixture.close);
  expect(await fixture.changePassword(), isFalse);
  await fixture.profileSeen.future.timeout(const Duration(seconds: 1));
  expect(fixture.session.invalidations, 0);
}

Future<void> _keepSessionOnNetworkFailure() async {
  final _Fixture fixture = _Fixture(profileStatus: 200, offline: true);
  addTearDown(fixture.close);
  expect(await fixture.changePassword(), isFalse);
  await fixture.profileSeen.future.timeout(const Duration(seconds: 1));
  expect(fixture.session.invalidations, 0);
}

Future<void> _ignoreStaleFailure() async {
  final _Fixture fixture =
      _Fixture(profileStatus: 401, requestToken: 'old-token');
  addTearDown(fixture.close);
  expect(await fixture.changePassword(), isFalse);
  expect(fixture.adapter.requests, 1);
  expect(fixture.session.invalidations, 0);
}

Future<void> _profileFailure() async {
  final _Fixture fixture = _Fixture(profileStatus: 401);
  addTearDown(fixture.close);
  await expectLater(
      fixture.dio.get<dynamic>('/user/profile'), throwsA(isA<DioException>()));
  await fixture.session.invalidated.future.timeout(const Duration(seconds: 1));
  expect(fixture.adapter.requests, 1);
}

/// 使用真实请求拦截链，所有响应由内存适配器提供。
class _Fixture {
  _Fixture(
      {required int profileStatus,
      bool offline = false,
      String requestToken = 'current-token'}) {
    FxDio().register(host,
        options: HostOptions(
            enableLog: false,
            repInterceptor: FlutterUnitResponseInterceptor()));
    dio = FxDio()[host];
    adapter = _Adapter(profileStatus: profileStatus, offline: offline);
    dio.httpClientAdapter = adapter;
    dio.options.headers['Authorization'] = 'Bearer $requestToken';
    dio.interceptors
        .add(FlutterUnitSessionInterceptor(users: session, host: host));
    dio.interceptors.add(InterceptorsWrapper(
        onResponse: _recordResponse, onError: _recordError));
  }

  /// 测试专用请求宿主。
  final FlutterUnitHost host = const FlutterUnitHost();

  /// 不访问持久存储的用户会话。
  final _Session session = _Session();

  /// 资料验证响应完成信号。
  final Completer<void> profileSeen = Completer<void>();

  /// 安装了真实宿主拦截器的 HTTP 客户端。
  late final Dio dio;

  /// 记录请求次数的测试响应提供者。
  late final _Adapter adapter;

  Future<bool> changePassword() => HttpFxUserRepository(host: host)
      .changePassword(oldPassword: 'test-old', newPassword: 'test-new');

  void _recordResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    _recordProfile(response.requestOptions);
    handler.next(response);
  }

  void _recordError(DioException error, ErrorInterceptorHandler handler) {
    _recordProfile(error.requestOptions);
    handler.next(error);
  }

  void _recordProfile(RequestOptions options) {
    if (options.path.endsWith('/user/profile') && !profileSeen.isCompleted) {
      profileSeen.complete();
    }
  }

  Future<void> close() async {
    await Future<void>.delayed(Duration.zero);
    FxDio().unregister(host);
    await session.close();
  }
}

/// 替代凭据存储和注销操作，不触及真实账号。
class _Session extends Cubit<FxUserSession> implements FxUserSessionCubit {
  _Session()
      : super(FxAuthed(const FxUserIdentityCodec()
            .decode(const FxUser(id: '42', displayName: '测试用户'))));

  /// 当前模拟凭据。
  UserCredential? _current =
      const BearerCredential(accessToken: 'current-token');

  /// 会话失效次数。
  int invalidations = 0;

  /// 会话失效完成信号。
  final Completer<void> invalidated = Completer<void>();

  @override
  UserCredential? get credential => _current;

  @override
  Future<void> handleUnauthorized() async {
    invalidations++;
    _current = null;
    emit(const FxGuest());
    if (!invalidated.isCompleted) invalidated.complete();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Adapter implements HttpClientAdapter {
  _Adapter({required this.profileStatus, required this.offline});

  /// 资料验证接口的预设结果。
  final int profileStatus;

  /// 是否模拟资料验证时断网。
  final bool offline;

  /// 请求总次数，检测误发和无限重试。
  int requests = 0;

  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<Uint8List>? requestStream, Future<void>? cancelFuture) async {
    requests++;
    final bool profile = options.path.endsWith('/user/profile');
    if (profile && offline) {
      throw DioException(
          requestOptions: options, type: DioExceptionType.connectionError);
    }
    final int status = profile ? profileStatus : 401;
    final Map<String, dynamic> body = status == 200
        ? <String, dynamic>{
            'code': 'SUCCESS',
            'data': <String, dynamic>{'id': '42'}
          }
        : <String, dynamic>{
            'code': 'UNAUTHORIZED',
            'message': profile ? '登录状态已失效' : '旧密码错误'
          };
    return ResponseBody.fromString(jsonEncode(body), status,
        headers: <String, List<String>>{
          'content-type': <String>['application/json']
        });
  }

  @override
  void close({bool force = false}) {}
}
