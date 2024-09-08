import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage/storage.dart';
const String kAppSpKey = 'app-config';

class AppConfigCao{
  final SharedPreferences sp;
  AppConfigCao(this.sp);

  Future<bool> write(AppConfigPo appConfigPo) async {
    String config = json.encode(appConfigPo);
    return sp.setString(kAppSpKey, config);
  }

  Future<AppConfigPo> read() async {
    String content = sp.getString(kAppSpKey) ?? "{}";
    return AppConfigPo.fromPo(json.decode(content));
  }
}