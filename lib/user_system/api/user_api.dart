import 'package:flutter_unit/app/res/path_unit.dart';
import 'package:flutter_unit/app/utils/http_utils/http_util.dart';
import 'package:flutter_unit/app/utils/http_utils/result_bean.dart';
import 'package:flutter_unit/user_system/model/user.dart';

/// create by 张风捷特烈 on 2021/1/17
/// contact me by email 1981462002@qq.com
/// 说明:

class UserApi {
  static Future<ResultBean<bool>> register({String email, String code}) async {

    var result = await HttpUtil.getInstance().client.post(PathUnit.register,
        data: {"email": email, "activeCode": code}).catchError((err) {
      return ResultBean.error('请求错误: ${err.toString()}');
    });

    if (result.data != null) {
      return ResultBean.fromData<bool>(result.data);
    }

    return ResultBean.error('请求错误');
  }

  static Future<ResultBean<User>> login({String username, String password}) async {

    var result = await HttpUtil.getInstance().client.post(PathUnit.login,
        data: {"username": username, "password": password}).catchError((err) {
      return ResultBean.error('请求错误: ${err.toString()}');
    });

    if (result.data != null) {
      if(result.data['status']){
        return ResultBean<User>(
          msg: result.data['msg'],
          data: User.fromJson(result.data['data']),
          status: result.data['status'],
        );
      }else{
        return ResultBean<User>(
          msg: result.data['msg'],
          data: null,
          status: false,
        );
      }

    }

    return ResultBean.error('请求错误');
  }
}
