import 'package:dio/dio.dart';
import 'package:fx_trace/fx_trace.dart';

/// 解包 FlutterUnitServer 的统一 API 响应。
class FlutterUnitResponseInterceptor extends InterceptorsWrapper {
  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final dynamic body = response.data;
    if (response.statusCode == HttpCode.ok.value && body is Map) {
      if (body['status'] is bool && !body.containsKey('code')) {
        handler.next(response);
        return;
      }
      final String code = body['code']?.toString() ?? '';
      final String message = body['message']?.toString() ?? '';
      if (code == 'SUCCESS') {
        response.data = body['data'];
        response.statusMessage = message;
        handler.next(response);
        return;
      }
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: FlutterUnitApiTrace(message: message, error: body),
        ),
      );
      return;
    }
    handler.next(response);
  }
}

/// FlutterUnitServer 返回的业务异常。
class FlutterUnitApiTrace with Code, Trace {
  @override
  final int? value;

  @override
  final String message;

  @override
  final Object error;

  FlutterUnitApiTrace({
    this.value,
    required this.message,
    required this.error,
  });

  @override
  Code? get code => this;

  @override
  StackTrace? get stack => null;
}
