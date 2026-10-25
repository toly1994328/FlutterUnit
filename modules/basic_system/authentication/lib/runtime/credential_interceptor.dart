import 'package:dio/dio.dart';
import 'package:unit_env/unit_env.dart';

/// 会话恢复可能早于启动配置加载，为首个资料请求补齐已恢复的凭据。
class FlutterUnitCredentialInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String? token = UnitEnv.accessToken;
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
