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
  Host get unit => FxDio()<UnitHost>();

  @override
  Future<ApiRet<Repository>> getFlutterUnitRepo() async {
    return unit.get<Repository>(UnitApi.repository.path, convertor: (data) {
      dynamic repoStr = data['data']['repositoryData'];
      return Repository.fromJson(json.decode(repoStr));
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
      convertor: (data) => data['data']
          .map<Issue>((e) => Issue.fromJson(json.decode(e['pointData'])))
          .toList(),
    );
  }

  @override
  Future<ApiRet<List<IssueComment>>> getIssuesComment(int pointId) async {
    return unit.get<List<IssueComment>>("${UnitApi.pointComment.path}$pointId",
        convertor: (data) => data['data']
            .map<IssueComment>((e) =>
                IssueComment.fromJson(json.decode(e['pointCommentData'])))
            .toList());
  }
}
