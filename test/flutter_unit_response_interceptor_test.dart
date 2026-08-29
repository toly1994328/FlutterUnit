import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

// 根工程测试直接验证 workspace 子包中的响应拦截器。
// ignore: avoid_relative_lib_imports
import '../modules/basic_system/app/lib/http/flutter_unit/flutter_unit_response_interceptor.dart';

void main() {
  test('分类同步旧协议响应不会被统一拦截器拒绝', () async {
    final Dio dio = _createDio({'status': true, 'data': true});

    final Response<dynamic> response = await dio.post<dynamic>(
      '/categoryData/sync',
    );

    expect(response.data, {'status': true, 'data': true});
  });

  test('新协议成功响应仍会正常解包', () async {
    final Dio dio = _createDio({
      'code': 'SUCCESS',
      'message': 'ok',
      'data': {'id': 1},
    });

    final Response<dynamic> response = await dio.get<dynamic>('/unit/example');

    expect(response.data, {'id': 1});
  });
}

Dio _createDio(Map<String, dynamic> body) {
  final Dio dio = Dio();
  dio.httpClientAdapter = _JsonAdapter(body);
  dio.interceptors.add(FlutterUnitResponseInterceptor());
  return dio;
}

/// 为响应拦截器测试提供固定 JSON 响应。
class _JsonAdapter implements HttpClientAdapter {
  /// 测试请求返回的 JSON 对象。
  final Map<String, dynamic> body;

  _JsonAdapter(this.body);

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return ResponseBody.fromString(
      jsonEncode(body),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
