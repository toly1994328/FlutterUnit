import 'package:flutter/cupertino.dart';
import 'package:flutter_unit/app/res/path_unit.dart';
import 'package:flutter_unit/app/utils/http_utils/http_util.dart';
import 'package:flutter_unit/app/utils/http_utils/result_bean.dart';

/// create by 张风捷特烈 on 2021/1/17
/// contact me by email 1981462002@qq.com
/// 说明:

class SystemApi {
  static Future<ResultBean<String>> sendEmail({@required String email}) async {
    var result =
        await HttpUtil.getInstance().client.post(PathUnit.sendEmail + "$email");

    if (result.data != null) {
      return ResultBean.fromData<String>(result.data);
    }

    return ResultBean.error('请求错误');
  }
}
