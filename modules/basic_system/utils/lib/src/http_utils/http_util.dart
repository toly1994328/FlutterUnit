import 'package:dio/dio.dart';

import 'token_interceptor.dart';

const Duration _kReceiveTimeout = Duration(milliseconds: 5000);
const Duration _kSendTimeout = Duration(milliseconds: 5000);
const Duration _kConnectTimeout = Duration(milliseconds: 5000);

class HttpUtil {
  TokenInterceptors? tokenInterceptors;

  static final HttpUtil _instance = HttpUtil._internal();

  Dio? _dio;

  static HttpUtil get instance => _instance;

  ///通用全局单例，第一次使用时初始化
  HttpUtil._internal() {
      _dio ??= Dio(
        BaseOptions(
            connectTimeout: _kConnectTimeout,
            sendTimeout: _kSendTimeout,
            receiveTimeout: _kReceiveTimeout),
      );
      // _dio!.interceptors.add(LogsInterceptors());
      // _dio.interceptors.add(ResponseInterceptors());
  }


  Dio get client => _dio!;

  void setToken(String token) {
    print('---token---$token-------');
    tokenInterceptors = TokenInterceptors(token: token);
    _dio!.interceptors.add(tokenInterceptors!);
  }

  void deleteToken() {
    _dio!.interceptors.remove(tokenInterceptors);
  }

  void rebase(String baseIp) {
    _dio!.options.baseUrl = baseIp;
  }
}
