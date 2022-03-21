import 'package:shared_preferences/shared_preferences.dart';

/// create by 张风捷特烈 on 2020/6/17
/// contact me by email 1981462002@qq.com
/// 说明: 

class LocalStorage {

  static String tokenKey= "token_key";
  static String userKey= "user_key";
  static String dbVersionKey= "db_version_key";

  static SharedPreferences? _sp;

  // 如果_sp已存在，直接返回，为null时创建
  static Future<SharedPreferences> get sp async {
    if (_sp == null) {
      _sp = await SharedPreferences.getInstance();
    }
    return _sp!;
  }

  static Future<bool> save(String key, String value) async {
    return (await sp).setString(key, value);
  }

  static dynamic get(String key) async {
    return (await sp).get(key);
  }

  static Future<bool> saveInt(String key, int value) async {
    return (await sp).setInt(key, value);
  }

  static Future<int?> getInt(String key) async {
    return (await sp).getInt(key);
  }

  static Future<bool> remove(String key) async {
    return (await sp).remove(key);
  }
}