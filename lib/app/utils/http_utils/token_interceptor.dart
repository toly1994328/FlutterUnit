import 'package:dio/dio.dart';

const String _kTokenKey = 'Authorization';
const String _kTokenPrefix = 'Bearer ';

class TokenInterceptors<T> extends InterceptorsWrapper {

  String token;


  TokenInterceptors({this.token=''});

  @override
  Future onRequest(RequestOptions options) async{
    // print('----RequestOptions---${options.path}------------');
    if(token.isNotEmpty){
      options.headers[_kTokenKey] = '$_kTokenPrefix$token';
    }
    return options;
  }
}
