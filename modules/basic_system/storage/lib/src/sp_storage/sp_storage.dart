import 'package:shared_preferences/shared_preferences.dart';

import 'cao/app_config_cao.dart';

class SpStorage {
  SpStorage._();

  static SpStorage? _storage;

  static SpStorage get instance {
    _storage = _storage ?? SpStorage._();
    return _storage!;
  }

  SharedPreferences? _sp;

  SharedPreferences get spf => _sp!;

  late AppConfigCao _appConfig;

  AppConfigCao get appConfig => _appConfig;

  Future<void> initSp() async {
    if (_sp != null) return;
    _sp = _sp ?? await SharedPreferences.getInstance();
    _appConfig = AppConfigCao(_sp!);
  }
}
