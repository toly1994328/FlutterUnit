import 'dart:developer' as developer;

import 'package:unit_env/unit_env.dart';
import 'package:utils/utils.dart';

const String _categoryDataPath = '/categoryData';
const String _categoryDataSyncPath = '/categoryData/sync';

/// 组件分类与收藏数据的云端快照接口。
abstract final class CategoryApi {
  /// 将本地分类和收藏快照上传到当前 FlutterUnit 服务。
  static Future<TaskResult<bool>> uploadCategoryData({
    required String data,
    required String likeData,
  }) async {
    try {
      final FlutterUnitHost host = FxDio()<FlutterUnitHost>();
      final Response<dynamic> response = await FxDio()[host].post<dynamic>(
        _categoryDataSyncPath,
        data: {'data': data, 'likeData': likeData},
      );
      final Map<String, dynamic>? body = _jsonMap(response.data);
      if (body?['status'] case final bool status) {
        return TaskResult.success(data: status);
      }
      return const TaskResult.error(msg: '服务端响应格式错误');
    } catch (error, stackTrace) {
      developer.log(
        '上传分类快照失败',
        name: 'FlutterUnit.CategorySync',
        error: error,
        stackTrace: stackTrace,
        level: 1000,
      );
      return TaskResult.error(msg: '请求错误: $error');
    }
  }

  /// 获取当前登录账号保存在云端的分类和收藏快照。
  static Future<TaskResult<CategoryData>> getCategoryData() async {
    try {
      final FlutterUnitHost host = FxDio()<FlutterUnitHost>();
      final Response<dynamic> response =
          await FxDio()[host].get<dynamic>(_categoryDataPath);
      final Map<String, dynamic>? body = _jsonMap(response.data);
      if (body?['status'] != true) {
        return const TaskResult.error(msg: '服务端返回失败状态');
      }
      final Map<String, dynamic>? data = _jsonMap(body?['data']);
      if (data == null) {
        return const TaskResult.success(data: null);
      }
      return TaskResult.success(data: CategoryData.fromJson(data));
    } catch (error, stackTrace) {
      developer.log(
        '获取或解析分类快照失败',
        name: 'FlutterUnit.CategorySync',
        error: error,
        stackTrace: stackTrace,
        level: 1000,
      );
      return TaskResult.error(msg: '请求错误: $error');
    }
  }

  static Map<String, dynamic>? _jsonMap(dynamic value) {
    return value is Map<String, dynamic> ? value : null;
  }
}

class CategoryData {
  /// 云端快照记录 ID。
  final int categoryDataId;

  /// 快照所属账号 ID。
  final int userId;

  /// JSON 编码的组件分类数据。
  final String data;

  /// JSON 编码的收藏组件 ID。
  final String likeData;

  const CategoryData({
    required this.categoryDataId,
    required this.userId,
    required this.data,
    required this.likeData,
  });

  factory CategoryData.fromJson(Map<String, dynamic> map) {
    return CategoryData(
      categoryDataId: map['categoryDataId'] as int,
      userId: map['userId'] as int,
      data: map['data'] as String,
      likeData: map['likeData'] as String,
    );
  }
}
