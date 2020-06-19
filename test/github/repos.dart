import 'package:flutter_unit/app/api/github/issues_api.dart';
import 'package:flutter_unit/app/api/github/repos_api.dart';

/// create by 张风捷特烈 on 2020/6/17
/// contact me by email 1981462002@qq.com
/// 说明:

main() {
  getRepos();
}

void getRepos() async {
  var result = await ReposApi.getRepos(
      username: "toly1994328",
      repository: "FlutterUnit");
  print(result);
}
