import 'package:app/app.dart';
import 'package:utils/utils.dart';


/// create by 张风捷特烈 on 2021/2/24
/// contact me by email 1981462002@qq.com
/// 说明:

class CategoryApi {
  static Future<TaskResult<bool>> uploadCategoryData(
      {required String data, required String likeData}) async {
    String errorMsg = "";

    try {
      var result = await HttpUtil.instance.client.post(
              PathUnit.categoryDataSync,
              data: {"data": data, "likeData": likeData});
      print(result.data);
      if (result.data != null) {
            return TaskResult.success(data:result.data['status']);
          }
    } catch (e) {
      print(e);
      errorMsg = e.toString();
    }

    return TaskResult.error(msg: '请求错误: $errorMsg');
  }

  static Future<TaskResult<CategoryData>> getCategoryData() async {
    String errorMsg = "";
    var result = await HttpUtil.instance
        .client
        .get(PathUnit.categoryData)
        .catchError((err) {
      errorMsg  =err.toString();

    });

    // 获取的数据非空且 status = true
    if (result.data != null && result.data['status']) {
      // 说明有数据
      if (result.data['data'] != null) {
        return TaskResult.success(data:CategoryData.fromJson(result.data['data']));
      } else {
        return const TaskResult.success(data:null);
      }
    }

    return TaskResult.error(msg: '请求错误: $errorMsg');
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