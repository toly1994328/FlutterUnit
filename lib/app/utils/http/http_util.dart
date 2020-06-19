import 'dart:collection';

import 'package:dio/dio.dart';
import 'rep_result.dart';

import 'code.dart';
import 'interceptors/log_interceptor.dart';
import 'interceptors/response_interceptor.dart';
import 'interceptors/token_interceptor.dart';

const String _kBaseUrl = "https://api.github.com";
const int _kReceiveTimeout = 15000;
const int _kSendTimeout = 15000;
const int _kConnectTimeout = 15000;
const String _kTokenKey = 'Authorization';
const String _kTokenPrefix = 'Bearer ';

///http请求
class HttpUtil {
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

  static HttpUtil _instance = HttpUtil._internal();

  Dio _dio;

  void setToken(String token) {
    _tokenInterceptors.token = token;
  }

  void clearToken(String token) {
    setToken(null);
  }

  ///通用全局单例，第一次使用时初始化
  HttpUtil._internal({String token}) {
    if (null == _dio) {
      _dio = Dio(BaseOptions(
        baseUrl: _kBaseUrl,
        connectTimeout: _kReceiveTimeout,
        receiveTimeout: _kConnectTimeout,
        sendTimeout: _kSendTimeout,
      ));

      _dio.interceptors.add(LogsInterceptors());
      _dio.interceptors.add(ResponseInterceptors());
      _dio.interceptors.add(_tokenInterceptors);
    }
  }

  static HttpUtil getInstance() {
    return _instance;
  }

  void rebase(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  final TokenInterceptor _tokenInterceptors = TokenInterceptor();

  Future<RepResult> get(String url,
      {Map<String, dynamic> header, Map<String, dynamic> param}) async {
    Response response;
    try {
      response = await _dio.get(url, queryParameters: param);
    } on DioError catch (e) {
      return resultError(e);
    }
    if (response.data is DioError) {
      return resultError(response.data);
    }
    return response.data;
  }

  Future<RepResult> post(String url,
      {Map<String, dynamic> param, data, Options options,}) async {
    Response response;
    try {
      response = await _dio.post(
          url, data: data, queryParameters: param, options: options);
    } on DioError catch (e) {
      return resultError(e);
    }
    if (response.data is DioError) {
      return resultError(response.data);
    }
    return response.data;
  }

  Future<RepResult> put(String url, {Map<String, dynamic> param, data}) async {
    Response response;
    try {
      response = await _dio.put(url, data: data, queryParameters: param);
    } on DioError catch (e) {
      return resultError(e);
    }
    if (response.data is DioError) {
      return resultError(response.data);
    }
    return response.data;
  }

  Future<RepResult> delete(String url,
      {Map<String, dynamic> param, data}) async {
    Response response;
    try {
      response = await _dio.delete(url, data: data, queryParameters: param);
    } on DioError catch (e) {
      return resultError(e);
    }
    if (response.data is DioError) {
      return resultError(response.data);
    }
    return response.data;
  }

  resultError(DioError e) {
    Response errorResponse;
    if (e.response != null) {
      errorResponse = e.response;
    } else {
      errorResponse = Response(statusCode: 666);
    }
    if (e.type == DioErrorType.CONNECT_TIMEOUT ||
        e.type == DioErrorType.RECEIVE_TIMEOUT) {
      errorResponse.statusCode = Code.NETWORK_TIMEOUT;
    }
    return RepResult(
        Code.errorHandleFunction(errorResponse.statusCode, e.message, false),
        false,
        errorResponse.statusCode);
  }
}