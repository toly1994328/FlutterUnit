
import 'package:storage/storage.dart';

import 'db_storage/flutter/flutter_db_store.dart';
import 'db_storage/flutter_unit/flutter_unit_db_store.dart';

class AppStorage {

  AppStorage._();

  static AppStorage? _instance;

  factory AppStorage() => _instance ??= AppStorage._();

  final FlutterDbStore _flutterDb = FlutterDbStore();
  final FlutterUnitDbStore _flutterUnitDb = FlutterUnitDbStore();

  FlutterDbStore get flutter => _flutterDb;
  FlutterUnitDbStore get flutterUnit => _flutterUnitDb;

  Future<void> init() async{
    await _flutterDb.open();
    await _flutterUnitDb.open();
  }

  void close() async{
    await _flutterDb.close();
    await _flutterUnitDb.close();
  }

}
