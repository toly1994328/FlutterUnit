import 'dart:convert';

import 'package:flutter_unit/app/utils/http/http_util.dart';
import 'package:flutter_unit/repositories/github_user_repository.dart';

/// create by 张风捷特烈 on 2020/6/17
/// contact me by email 1981462002@qq.com
/// 说明:

main() async {

  var username ="toly1994328";
  var password ="@#1994328zfjtl";

  var repository = GithubUserRepository();
  var result = await repository.authenticate(username: username, password: password);

  print(result);
}