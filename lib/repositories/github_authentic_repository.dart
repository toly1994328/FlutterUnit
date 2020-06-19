import 'dart:async';

import 'package:flutter_unit/storage/dao/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GithubAuthenticRepository {
  String _token;

  String get token => _token;

  //删除token
  Future<void> deleteToken() async {
    var success = await LocalStorage.remove(LocalStorage.tokenKey);
    return success;
  }

  //固化token
  Future<bool> persistToken(String token) async {
    var success = await LocalStorage.save(LocalStorage.tokenKey,token);
    return success;
  }

  //检查是否有token
  Future<bool> hasToken() async {
    var token = await LocalStorage.get(LocalStorage.tokenKey);
    return token == null;
  }
}
