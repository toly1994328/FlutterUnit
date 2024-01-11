import 'dart:convert';

import 'package:dio/dio.dart';

import '../model/github_model.dart';
import '../model/issue.dart';
import '../model/repository.dart';


/// create by 张风捷特烈 on 2020/6/17
/// contact me by email 1981462002@qq.com
/// 说明:

const kBaseUrl = 'http://toly1994.com:8080/api/v1';

class IssuesApi {
  static Dio dio = Dio(BaseOptions(baseUrl: kBaseUrl));

  static Future<Repository> getRepoFlutterUnit() async {
    Response<dynamic> rep = await dio.get('/repository/name/FlutterUnit');
    dynamic repoStr = rep.data['data']['repositoryData'];
    return Repository.fromJson(json.decode(repoStr));
  }

  static Future<List<Issue>> getIssues(
      {int page = 1, int pageSize = 100}) async {
    List<dynamic> res = (await dio.get('/point',
            queryParameters: {"page": page, "pageSize": pageSize}))
        .data['data'] as List;
    return res.map((e) => Issue.fromJson(json.decode(e['pointData']))).toList();
  }

  static Future<List<IssueComment>> getIssuesComment(int pointId) async {
    List<dynamic> res = (await dio.get('/pointComment/$pointId')).data['data'] as List;
    return res
        .map((e) => IssueComment.fromJson(json.decode(e['pointCommentData'])))
        .toList();
  }
}
