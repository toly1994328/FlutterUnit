import 'package:unit_env/unit_env.dart';

import '../model/model.dart';

class PackageRequest with FlutterUnitHostMixin {
  Future<ApiRet<dynamic>> getAllPackages() async {
    return host.get(PkgUrl.listPackages.path, convertor: (e) => e);
  }

  Future<ApiRet<dynamic>> insertPackage(Map<String, dynamic> data) async {
    return host.post('/packages/import', data: data, convertor: (e) => e);
  }

  Future<ApiRet<dynamic>> deletePackages(String name) async {
    return host.delete('/packages/$name', convertor: (e) => e);
  }

  Future<ApiRet<dynamic>> addCategories({
    required String key,
    required String name,
    required String? desc,
  }) async {
    return addCategoriesRaw({
      'key': key,
      'name': name,
      'description': desc ?? '',
    });
  }

  Future<ApiRet<List<PluginModel>>> getCategoriesPackage({
    required String key,
    int page = 1,
    int pageSize = 10,
    String? sortBy,
  }) async {
    return host.get('/categories/$key/export', queryParameters: {
      'sort_by': sortBy ?? 'downloads',
      'page': page,
      'page_size': pageSize,
    }, convertor: (data) {
      List<dynamic> list = data as List<dynamic>;
      return list.map((json) => PluginModel.fromJson(json)).toList();
    });
  }

  Future<ApiRet<dynamic>> addCategoriesRaw(Map<String, dynamic> data) async {
    return host.post('/categories', data: data, convertor: (e) => e);
  }

  Future<ApiRet<dynamic>> addToCategories(
    String categoryKey,
    List<String> packageNames,
  ) async {
    return host.post('/packages/add_to_category',
        data: {
          "category_key": categoryKey,
          "package_names": packageNames,
        },
        convertor: (e) => e);
  }

  Future<ApiRet<List<Category>>> getCategories() async {
    return host.get<List<Category>>('/categories', queryParameters: {
      'page': 1,
      'page_size': 100,
    }, convertor: (data) {
      List<dynamic> list = data as List<dynamic>;
      dynamic value =
          list.map<Category>((json) => Category.fromJson(json)).toList();
      return value;
    });
  }

  Future<ApiRet<CommentsResponse>> getPackageComments(
    int packageId, {
    int page = 1,
    int pageSize = 10,
  }) async {
    return host.get('/packages/$packageId/comments', queryParameters: {
      'page': page,
      'page_size': pageSize,
    }, convertor: (data) {
      final List<dynamic> list = data as List<dynamic>;
      final List<Comment> comments =
          list.map((dynamic json) => Comment.fromJson(json)).toList();
      return CommentsResponse(data: comments, total: comments.length);
    });
  }

  Future<ApiRet<dynamic>> sendComment(int packageId, String content,
      {int? parentId}) async {
    Map<String, dynamic> data = {
      'content': content,
    };
    if (parentId != null && parentId != -1) {
      data['parent_id'] = parentId;
    }
    return host.post('/packages/$packageId/comments',
        data: data, convertor: (e) => e);
  }

  Future<ApiRet<PublicUserProfile>> getPublicUserProfile(int userId) async {
    return host.get(
      '/users/$userId/public-profile',
      convertor: (dynamic data) =>
          PublicUserProfile.fromJson(data as Map<String, dynamic>),
    );
  }

  /// 提交不依赖具体业务模块的通用举报工单。
  Future<ApiRet<dynamic>> submitReport({
    required String resourceType,
    required String resourceId,
    int? targetUserId,
    required String reason,
    String? detail,
    Map<String, dynamic> metadata = const <String, dynamic>{},
  }) async {
    return host.post(
      '/moderation/reports',
      data: <String, dynamic>{
        'resource_type': resourceType,
        'resource_id': resourceId,
        'target_user_id': targetUserId,
        'reason': reason,
        'detail': detail,
        'metadata': metadata,
      },
      convertor: (dynamic data) => data,
    );
  }

  Future<ApiRet<dynamic>> blockCommentAuthor(
    int commentId, {
    required String reason,
  }) async {
    return host.post(
      '/comments/$commentId/block-author',
      data: <String, dynamic>{
        'resource_type': 'package_comment',
        'resource_id': '$commentId',
        'reason': reason,
        'metadata': const <String, dynamic>{'source': 'block_user'},
      },
      convertor: (dynamic data) => data,
    );
  }

  Future<ApiRet<List<Comment>>> getCommentReplies(
    int commentId, {
    int page = 1,
    int pageSize = 15,
  }) async {
    return host.get('/comments/$commentId/replies', queryParameters: {
      'page': page,
      'page_size': pageSize,
    }, convertor: (data) {
      List<dynamic> list = data as List<dynamic>;
      return list.map((json) => Comment.fromJson(json)).toList();
    });
  }

  Future<ApiRet<dynamic>> submitFeedback({
    required String feedbackType,
    required String title,
    required String content,
  }) async {
    return host.post('/feedback',
        data: {
          'feedback_type': feedbackType,
          'title': title,
          'content': content,
        },
        convertor: (e) => e);
  }

  Future<void> insertPackages(String category, List<dynamic> jsonData) async {
    List<String> packageNames = [];
    for (dynamic data in jsonData) {
      print("insertPackages:${data['name']}");
      await insertPackage(data);
      packageNames.add(data['name']);
    }
    ApiRet<dynamic> ret = await addToCategories(category, packageNames);
    if (ret.success) {
      print(ret.data);
    }
  }
}

enum PkgUrl {
  listPackages("/packages"),
  ;

  final String path;
  final Method? method;

  const PkgUrl(this.path, [this.method = Method.get]);
}
