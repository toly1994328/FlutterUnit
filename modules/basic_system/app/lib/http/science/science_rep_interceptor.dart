import 'package:dio/dio.dart';
import 'package:fx_trace/fx_trace.dart';

class ScienceRepInterceptor extends InterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handleResponse(response);
    super.onResponse(response, handler);
  }

  void handleResponse(Response response) {
    if (response.statusCode == HttpCode.ok.value) {
      bool success = response.data?['status'] == true;
      String message = response.data['msg'];
      if (success) {
        response.data = response.data['data'];
        response.statusMessage = message;
      } else {
        throw ApiTrace(message: message, error: response.data);
      }
      return;
    }
    throw ApiTrace(message: response.statusMessage ?? '', error: response.data);
  }
}

class ApiTrace with Code, Trace {
  @override
  final int? value;

  @override
  final String message;

  @override
  final Object error;

  ApiTrace({
    this.value,
    required this.message,
    required this.error,
  });

  @override
  Code? get code => this;

  @override
  StackTrace? get stack => null;
}
