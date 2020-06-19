import 'package:dio/dio.dart';

/// create by 张风捷特烈 on 2020/4/28
/// contact me by email 1981462002@qq.com
/// 说明:


const String _kTokenKey = 'Authorization';
const String _kTokenPrefix = 'token ';

class TokenInterceptor extends InterceptorsWrapper {
  String _token;

  set token(String value) {
    _token = value;
  }

  @override
  onRequest(RequestOptions options) async {
    //_token非空,拦截请求,添加token
    if(_token!=null&&_token.isNotEmpty){
      options.headers[_kTokenKey] = '$_kTokenPrefix$_token';
    }
    return options;
  }

  @override
  onResponse(Response response) async {
//    try {
//      var responseJson = response.data;
//      if (response.statusCode == 201 && responseJson["token"] != null) {
//        _token = 'token ' + responseJson["token"];
//        await LocalStorage.save(Config.TOKEN_KEY, _token);
//      }
//    } catch (e) {
//      print(e);
//    }
    return response;
  }

  ///清除授权
  clearAuthorization() {
//    this._token = null;
//    LocalStorage.remove(Config.TOKEN_KEY);
//    releaseClient();
  }

  ///获取授权token
  getAuthorization() async {
//    String token = await LocalStorage.get(Config.TOKEN_KEY);
//    if (token == null) {
//      String basic = await LocalStorage.get(Config.USER_BASIC_CODE);
//      if (basic == null) {
//        //提示输入账号密码
//      } else {
//        //通过 basic 去获取token，获取到设置，返回token
//        return "Basic $basic";
//      }
//    } else {
//      this._token = token;
//      return token;
//    }
  }
}
