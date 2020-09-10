import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_unit/model/github/issue_comment.dart';
import 'package:flutter_unit/model/github/issue.dart';
import 'package:flutter_unit/model/github/repository.dart';

/// create by 张风捷特烈 on 2020/6/17
/// contact me by email 1981462002@qq.com
/// 说明:


const kBaseUrl= 'http://119.45.173.197:8080/api/v1';

class IssuesApi {

  static var dio = Dio(
    BaseOptions(
      baseUrl: kBaseUrl
    )
  );

  static Future<Repository> getRepoFlutterUnit() async{
    var rep = await dio.get('/repository/name/FlutterUnit');
    var repoStr = rep.data['data']['repositoryData'];
    return Repository.fromJson(json.decode(repoStr));
  }

  static Future<List<Issue>> getIssues() async {
    var res = (await dio.get('/point')).data['data'] as List;
    return res.map((e)=>Issue.fromJson(json.decode(e['pointData']))).toList();
  }

  static Future<List<IssueComment>> getIssuesComment(int pointId) async {
    var res = (await dio.get('/pointComment/$pointId')).data['data'] as List;
    return res.map((e)=>IssueComment.fromJson(json.decode(e['pointCommentData']))).toList();
  }
}

