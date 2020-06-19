import 'dart:convert';
import 'package:flutter_unit/app/utils/http/rep_result.dart';
import 'package:flutter_unit/model/github/github_user.dart';


/// create by 张风捷特烈 on 2020/6/1
/// contact me by email 1981462002@qq.com
/// 说明:

class GithubUserRepository {
  Future<GithubUser> getLocalUser() async {
//    return await LocalDao.dao.queryUser();
  }

  Future<void> setLocalUser(GithubUser userBean) async {
//    await LocalDao.dao.insert(userBean);
  }

  Future<RepResult> authenticate({
    String username,
    String password,
  }) async {
    String type = username + ":" + password;
    var bytes = utf8.encode(type);
    var base64Str = base64.encode(bytes);

//    var result = await GithubApi.authorizations(base64: base64Str);

//    result.msg = result.data["token"];

//    return result;

//    //  var result = await Api.login(username,password);
//    //  通过result获取token和用户信息
//    await Future.delayed(Duration(seconds: 1));//模拟登陆请求耗时
//    if(username=='toly'&& password =='111111'){
//      return LoginResult(
//        status: true,
//        msg: '你获得的token值',
//        user: UserBean(name: 'toly'),
//      );
//    }else{
//      return LoginResult(
//        status: false,
//        msg: '用户名密码错误',
//        user: null,
//      );
//    }
  }

  Future<void> deleteLocalUser() async {
//    return await LocalDao.dao.remove();
  }
}
