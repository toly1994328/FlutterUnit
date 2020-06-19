import 'package:flutter_unit/app/api/github/issues_api.dart';

/// create by 张风捷特烈 on 2020/6/17
/// contact me by email 1981462002@qq.com
/// 说明:

main() {
  getIssues();
}

void getIssues() async {
  var result = await IssuesApi.getIssues(
      username: "toly1994328",
      repository: "FlutterUnit",
      labels: "point",
      pageSize: 2);

  print(result);
}
