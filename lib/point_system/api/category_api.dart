import 'package:flutter_unit/app/res/path_unit.dart';
import 'package:flutter_unit/app/utils/http_utils/http_util.dart';
import 'package:flutter_unit/app/utils/http_utils/result_bean.dart';

/// create by 张风捷特烈 on 2021/2/24
/// contact me by email 1981462002@qq.com
/// 说明:

class CategoryApi {
  static Future<ResultBean<bool>> uploadCategoryData(
      {required String data, required String likeData}) async {
    String errorMsg = "";

    var result = await HttpUtil.getInstance().client.post(
        PathUnit.categoryDataSync,
        data: {"data": data, "likeData": likeData}).catchError((err) {
      errorMsg = err.toString();
    });

    if (result.data != null) {
      return ResultBean.fromData<bool>(result.data);
    }

    return ResultBean.error('请求错误: $errorMsg');
  }

  static Future<ResultBean<CategoryData>> getCategoryData() async {
    String errorMsg = "";
    var result = await HttpUtil.getInstance()
        .client
        .get(PathUnit.categoryData)
        .catchError((err) {
      errorMsg  =err.toString();

    });

    // 获取的数据非空且 status = true
    if (result.data != null && result.data['status']) {
      // 说明有数据
      if (result.data['data'] != null) {
        return ResultBean.ok<CategoryData>(CategoryData.fromJson(result.data['data']));
      } else {
        return ResultBean.ok<CategoryData>(null);
      }
    }

    return ResultBean.error('请求错误: $errorMsg');
  }
}

class CategoryData{
  final int categoryDataId;
  final int userId;
  final String data;
  final String likeData;

  CategoryData(
      {required this.categoryDataId,
      required this.userId,
      required this.data,
      required this.likeData});

  factory CategoryData.fromJson(Map<String, dynamic> map) {
    return CategoryData(
        categoryDataId: map['categoryDataId'],
        userId: map["userId"],
        likeData: map["likeData"],
        data: map["data"]);
  }
}