import 'package:dio/dio.dart';

class LogsInterceptors extends InterceptorsWrapper {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//    print("==========请求baseUrl：${options.baseUrl} ==========");
//    print("==========请求url：${options.path} ==========");
//    print('==========请求头: ' + options.headers.toString()+"==========");
//    if (options.data != null) {
//      print('==========请求参数: ' + options.data.toString()+"==========");
//    }
    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('==========请求异常: ' + err.toString()+"==========");
    if(err.response!=null){
      print('==========请求异常信息: ' + err.response.toString()+"==========");
    }
    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response); // continue
  }
}