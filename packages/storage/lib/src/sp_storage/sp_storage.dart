import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage/src/sp_storage/sp_keys.dart';

import 'models/app_config_po.dart';

class SpStorage {
  SpStorage._();

  static SpStorage? _storage;

  static SpStorage get instance {
    _storage = _storage ?? SpStorage._();
    return _storage!;
  }

  SharedPreferences? _sp;
  SharedPreferences get spf => _sp!;

  Future<void> initSpWhenNull() async {
    if (_sp != null) return;
    _sp = _sp ?? await SharedPreferences.getInstance();
  }

  Future<bool> saveAppConfig(AppConfigPo appConfigPo) async {
    await initSpWhenNull();
    String config = json.encode(appConfigPo);
    return _sp!.setString(kAppSpKey, config);
  }

  Future<AppConfigPo> readAppConfig() async {
    await initSpWhenNull();
    String content = _sp!.getString(kAppSpKey) ?? "{}";
    return AppConfigPo.fromPo(json.decode(content));
  }
}
