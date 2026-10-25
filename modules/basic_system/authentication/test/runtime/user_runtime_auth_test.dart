import 'dart:typed_data';

import 'package:authentication/runtime/credential_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unit_env/unit_env.dart';

void main() {
  test('启动配置未加载时，恢复后的凭据也会进入请求头', _earlyCredential);
}

Future<void> _earlyCredential() async {
  const FlutterUnitHost host = FlutterUnitHost();
  FxDio().register(host, options: const HostOptions(enableLog: false));
  final _RecordingAdapter adapter = _RecordingAdapter();
  FxDio()[host].httpClientAdapter = adapter;
  FxDio()[host].interceptors.add(FlutterUnitCredentialInterceptor());
  addTearDown(() => UnitEnv.accessToken = null);
  UnitEnv.accessToken = 'test-only-token';
  await FxDio()[host].get<dynamic>('/user/profile');
  expect(adapter.authorization, 'Bearer test-only-token');
  UnitEnv.accessToken = null;
  await FxDio()[host].get<dynamic>('/user/profile');
  expect(adapter.authorization, isNull);
}

/// 在内存中记录请求，避免测试访问正式服务。
class _RecordingAdapter implements HttpClientAdapter {
  /// 最近一次请求的认证头。
  Object? authorization;

  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<Uint8List>? requestStream, Future<void>? cancelFuture) async {
    authorization = options.headers['Authorization'];
    return ResponseBody.fromString('{}', 200, headers: <String, List<String>>{
      'content-type': <String>['application/json']
    });
  }

  @override
  void close({bool force = false}) {}
}
