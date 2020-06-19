import 'package:flutter_unit/app/utils/http/http_util.dart';
import 'package:flutter_unit/app/utils/http/rep_result.dart';
import 'package:flutter_unit/model/github/issue.dart';

/// create by 张风捷特烈 on 2020/6/17
/// contact me by email 1981462002@qq.com
/// 说明:

class IssuesApi {
  static getIssues({
    String username="toly1994328",
    String repository="FlutterUnit",
    String sort = 'created',
    String direction = 'desc',
    int page = 0,
    int pageSize = 10,
    String state = 'all',
    String labels = "all",
  }) async {
    var url = "/repos/$username/$repository/issues";

    var param = {
      "state": state,
      "sort": sort,
      "direction": direction,
      "labels": labels,
      "page": page,
      "per_page": pageSize,
    };

    var res = await HttpUtil.getInstance().get(url, param: param);

    if (res != null && res.status) {
      var data = res.data as List;

      if (data == null) {
        return RepResult(null, false, -1);
      }

      return RepResult(data.map(Issue.fromJson).toList(), true, 1);
    }
  }
}
