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
    final int status = response.statusCode ?? 0;
    if (status < 200 || status >= 300) {
      _reject(response, handler);
      return;
    }
    if (body is Map) {
      if (body['status'] is bool && !body.containsKey('code')) {
        if (body['status'] == false) {
          _reject(response, handler);
        } else {
          handler.next(response);
        }
        return;
      }
      final String code = body['code']?.toString() ?? '';
      final String message = body['message']?.toString() ?? '';
      if (code == 'SUCCESS') {
        final dynamic paginate = body['paginate'];
        response.data = paginate is Map
            ? <String, dynamic>{
                'data': body['data'],
                'paginate': Map<String, dynamic>.from(paginate),
              }
            : body['data'];
        response.statusMessage = message;
        handler.next(response);
        return;
      }
      _reject(response, handler);
      return;
    }
    handler.next(response);
  }

  /// fx_dio 接收所有 HTTP 状态，宿主必须在 void 转换器之前拒绝失败响应。
  void _reject(Response<dynamic> response, ResponseInterceptorHandler handler) {
    final dynamic body = response.data;
    final String message = body is Map
        ? (body['message'] ?? body['msg'] ?? response.statusMessage ?? '请求失败')
            .toString()
        : response.statusMessage ?? '请求失败';
    handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: FlutterUnitApiTrace(
            value: response.statusCode,
            message: message,
            error: body ?? <String, dynamic>{},
          ),
        ),
        true);
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
