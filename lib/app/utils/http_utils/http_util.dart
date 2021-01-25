
import 'package:dio/dio.dart';
import 'package:flutter_unit/app/res/path_unit.dart';

import 'logs_interceptor.dart';
import 'token_interceptor.dart';

const int _kReceiveTimeout = 5000;
const int _kSendTimeout = 5000;
const int _kConnectTimeout = 5000;

class HttpUtil {
  static HttpUtil _instance = HttpUtil._internal();
  Dio _dio;




  static const CODE_SUCCESS = 200;
  static const CODE_TIME_OUT = -1;

  factory HttpUtil() => _instance;
  TokenInterceptors tokenInterceptors;

  ///通用全局单例，第一次使用时初始化
  HttpUtil._internal() {
    if (null == _dio) {
      _dio = Dio(BaseOptions(
        baseUrl: PathUnit.baseUrl,
        connectTimeout: _kReceiveTimeout,
        receiveTimeout: _kConnectTimeout,
        sendTimeout: _kSendTimeout,
      ));
      _dio.interceptors.add(LogsInterceptors());
      // _dio.interceptors.add(ResponseInterceptors());
    }
  }

  static HttpUtil getInstance() {
      return _instance._default();

  }

  Dio get client => _dio;

  void setToken(String token){
    print('---token---$token-------');
    tokenInterceptors = TokenInterceptors(token: token);
    _dio.interceptors.add(tokenInterceptors);
  }
  void deleteToken(){
    _dio.interceptors.remove(tokenInterceptors);
  }

  void rebase(String baseIp) {
    _dio.options.baseUrl = baseIp;
  }

  //一般请求，默认域名
  HttpUtil _default() {
    if (_dio != null) {
      _dio.options.baseUrl=PathUnit.baseUrl;
      _dio.options.headers = {};
    }
    return this;
  }
}


