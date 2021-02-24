import 'package:flutter_unit/app/res/path_unit.dart';
import 'package:flutter_unit/app/utils/http_utils/http_util.dart';
import 'package:flutter_unit/app/utils/http_utils/result_bean.dart';

/// create by 张风捷特烈 on 2021/2/24
/// contact me by email 1981462002@qq.com
/// 说明:

class CategoryApi {


  static Future<ResultBean<bool>> uploadCategoryData(String data) async {
    var result = await HttpUtil.getInstance()
        .client
        .post(PathUnit.categoryDataSync, data: data)
        .catchError((err) {
      return ResultBean.error('请求错误: ${err.toString()}');
    });

    if (result.data != null) {
      return ResultBean.fromData<bool>(result.data);
    }

    return ResultBean.error('请求错误');
  }


  static Future<ResultBean<String>> getCategoryData() async {
    var result = await HttpUtil.getInstance()
        .client
        .get(PathUnit.categoryData)
        .catchError((err) {
      return ResultBean.error('请求错误: ${err.toString()}');
    });


    // 获取的数据非空且 status = true
    if (result.data != null && result.data['status']) {
      // 说明有数据
      if(result.data['data']!=null){
        var dataStr = result.data['data']['data'];
        return ResultBean.ok<String>(dataStr);
      }else{
        return ResultBean.ok<String>(null);
      }

    }

    return ResultBean.error('请求错误');
  }

}
