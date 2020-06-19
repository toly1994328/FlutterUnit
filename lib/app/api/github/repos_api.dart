import 'package:flutter_unit/app/utils/http/http_util.dart';
import 'package:flutter_unit/app/utils/http/rep_result.dart';
import 'package:flutter_unit/model/github/repository.dart';

/// create by 张风捷特烈 on 2020/6/17
/// contact me by email 1981462002@qq.com
/// 说明: 

class ReposApi{

  static Future<RepResult> getRepos({String username="toly1994328",String repository="FlutterUnit"}) async {

    var result = await HttpUtil.getInstance().get("/repos/$username/$repository");

    result.data = Repository.fromJson(result.data);

    return result;

  }
}