import 'dart:convert';

import '../../data/model/issue.dart';
import '../../data/model/issue_comment.dart';
import '../../data/model/repository.dart';
import 'package:fx_dio/fx_dio.dart';
import 'package:app/app.dart';

export 'package:fx_dio/fx_dio.dart' show ApiRet;

abstract interface class PointApi {
  /// 获取  github 中 FlutterUnit 仓库信息
  Future<ApiRet<Repository>> getFlutterUnitRepo();

  /// 获取  github 中 FlutterUnit 仓库 issues 列表
  Future<ApiRet<List<Issue>>> getIssues();

  Future<ApiRet<List<IssueComment>>> getIssuesComment(int pointId);
}

class PointApiImpl implements PointApi {
  Host get unit => FxDio()<FlutterUnitHost>();

  @override
  Future<ApiRet<Repository>> getFlutterUnitRepo() async {
    return unit.get<Repository>(UnitApi.repository.path, convertor: (data) {
      final dynamic payload = _catalogPayload(
        data['data'],
        legacyKey: 'repositoryData',
      );
      return Repository.fromJson(payload as Map<String, dynamic>);
    });
  }

  @override
  Future<ApiRet<List<Issue>>> getIssues(
      {int page = 1, int pageSize = 100}) async {
    return unit.get<List<Issue>>(
      UnitApi.point.path,
      queryParameters: {
        "page": page,
        "pageSize": pageSize,
      },
      convertor: (data) => data.map<Issue>((dynamic item) {
        return Issue.fromJson(
          _catalogPayload(item['data'], legacyKey: 'pointData'),
        );
      }).toList(),
    );
  }

  @override
  Future<ApiRet<List<IssueComment>>> getIssuesComment(int pointId) async {
    return unit.get<List<IssueComment>>("${UnitApi.pointComment.path}$pointId",
        convertor: (data) => data.map<IssueComment>((dynamic item) {
              return IssueComment.fromJson(
                _catalogPayload(
                  item['data'],
                  legacyKey: 'pointCommentData',
                ),
              );
            }).toList());
  }
}

/// 兼容迁移后的 JSONB 数据与旧数据中的 JSON 字符串字段。
dynamic _catalogPayload(dynamic value, {required String legacyKey}) {
  dynamic payload = value;
  if (payload is Map<String, dynamic> && payload[legacyKey] != null) {
    payload = payload[legacyKey];
  }
  return payload is String ? json.decode(payload) : payload;
}
