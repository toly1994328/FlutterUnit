import 'dart:convert';

import '../../data/model/issue.dart';
import '../../data/model/issue_comment.dart';
import '../../data/model/repository.dart';
import 'package:fx_dio/fx_dio.dart';
import 'package:app/app.dart';

abstract interface class PointApi {
  /// 获取  github 中 FlutterUnit 仓库信息
  Future<Repository> getFlutterUnitRepo();

  /// 获取  github 中 FlutterUnit 仓库 issues 列表
  Future<List<Issue>> getIssues();

  Future<List<IssueComment>> getIssuesComment(int pointId);
}

class PointApiImpl implements PointApi {
  Dio get dio => FxDio()<UnitHost>();

  @override
  Future<Repository> getFlutterUnitRepo() async {
    Response rep = await dio.get(UnitApi.repository.path);
    dynamic repoStr = rep.data['data']['repositoryData'];
    return Repository.fromJson(json.decode(repoStr));
  }

  @override
  Future<List<Issue>> getIssues({int page = 1, int pageSize = 100}) async {
    Response rep = await dio.get(UnitApi.point.path, queryParameters: {
      "page": page,
      "pageSize": pageSize,
    });
    return rep.data['data'].map<Issue>((e) => Issue.fromJson(json.decode(e['pointData']))).toList();
  }

  @override
  Future<List<IssueComment>> getIssuesComment(int pointId) async {
    Response rep = await dio.get("${UnitApi.pointComment.path}$pointId");

    return rep.data['data']
        .map<IssueComment>((e) => IssueComment.fromJson(json.decode(e['pointCommentData'])))
        .toList();
  }
}
