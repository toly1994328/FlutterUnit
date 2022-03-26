import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

const String _kTokenKey = 'Authorization';
const String _kTokenPrefix = 'Bearer ';

class TokenInterceptors<T> extends InterceptorsWrapper {
  String token;

  TokenInterceptors({this.token = ''});

  void Function()? onTokenDisabled;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (token != '') {
      bool disable = JwtDecoder.isExpired(token);
      if (disable) {
        onTokenDisabled?.call();
      }
    }
    if (token.isNotEmpty) {
      options.headers[_kTokenKey] = '$_kTokenPrefix$token';
    }
    return handler.next(options);
  }


}